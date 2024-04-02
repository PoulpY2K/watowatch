//
//  DetailSheetView.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 16/03/2024.
//

import SwiftData
import SwiftUI

struct DetailSheetView: View {
    // MARK: - PROPERTIES
    var movie: Movie
    
    @Environment(\.modelContext) private var modelContext
    @Query var movieList: [Movie]
    
    @State private var showingValidAlert = false
    @State private var showingErrorAlert = false
    
    let screenSize: CGRect = UIScreen.main.bounds
    
    /// Fonction permettant de formater la date
    func getTodayDateLocale() -> String {
        let dateFormatter: DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd"
        
        /// On vérifie que la date est bien valide, sinon on remplace par aucune
        if let englishDate: Date = dateFormatter.date(from: movie.releaseDate ?? "") {
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            dateFormatter.locale    = Locale(identifier: "FR-fr")
            return dateFormatter.string(from: englishDate)
        } else {
            return "Aucune date enregistrée"
        }
    }
    
    /// Fonction permettant de transformer le temps en minutes en heures + minutes
    func getTimeFormatted(time: Int) -> String {
        let hours = time / 60 % 60
        let minutes = time % 60
        
        return "\(hours)h\(minutes)m"
    }
    
    func addMovieToFavorites() {
        if (!movieList.isEmpty) {
            for storedMovie in movieList {
                if(storedMovie.id == movie.id) {
                    showingErrorAlert = true
                    return
                }
            }
        }
        
        modelContext.insert(movie)
        showingValidAlert = true
    }
    
    // MARK: - BODY
    var body: some View {
        VStack(content: {
            ZStack(alignment: .top, content: {
                VStack(content: {
                    /// Pendant que l'image charge, on remplace par un spinner et un fond gris
                    AsyncImage(url: TMDBService().getImageUrl(path: movie.backdropPath?.absoluteString ?? "")) {
                        image in image.resizable().aspectRatio(contentMode: .fill).frame(width: screenSize.width, height: screenSize.height/3).ignoresSafeArea().cornerRadius(10)
                    } placeholder: {
                        ProgressView().tint(.white).scaleEffect(1.5, anchor: .center).frame(width: screenSize.width, height: screenSize.height/3).ignoresSafeArea().background(.gray)
                    }
                    
                })
                
                VStack(content: {
                    /// Pendant que l'image charge, on remplace par un spinner et un fond gris
                    AsyncImage(url: TMDBService().getImageUrl(path: movie.posterPath?.absoluteString ?? "")){
                        image in
                        image.resizable().aspectRatio(contentMode: .fit).frame(width: screenSize.width/3, height: screenSize.height/4).clipShape(RoundedRectangle(cornerRadius: 10))
                    } placeholder: {
                        ProgressView().tint(.black).scaleEffect(1.5, anchor: .center).frame(width: screenSize.width/3, height: screenSize.height/4).ignoresSafeArea().background(.gray)
                    }.clipShape(RoundedRectangle(cornerRadius: 10))
                }).frame(minWidth:0, maxWidth: screenSize.width, minHeight: 0, maxHeight: screenSize.height/2.2, alignment: .bottom).clipShape(RoundedRectangle(cornerRadius: 10))
            })
            
            VStack(spacing: screenSize.width/25, content: {
                
                /// VStack du titre du film
                VStack(spacing: screenSize.width/90, content: {
                    Text(movie.title)
                        .font(.title)
                        .fontWeight(.heavy)
                    
                    if(movie.originalTitle != nil) {
                        Text(movie.originalTitle!)
                            .font(.callout)
                            .fontWeight(.regular)
                    }
                })
                
//                if(movie.genres != nil && !movie.genres!.isEmpty) {
//                    HStack(alignment: .center, spacing: screenSize.width/15, content: {
//                        
//                        let nbOfGenre: Int = movie.genres!.count >= 3 ? 3 : movie.genres!.count
//                        
//                        ForEach(0...nbOfGenre-1, id: \.self) {
//                            Text(movie.genres![$0].name)
//                                .font(.footnote)
//                                .fontWeight(.bold)
//                                .foregroundColor(Color.white)
//                                .padding(
//                                    EdgeInsets(
//                                        top: 5,
//                                        leading: 10,
//                                        bottom: 5,
//                                        trailing: 10) )
//                                .background(
//                                    Color(
//                                        red: .random(in: 0...0.5),
//                                        green: .random(in: 0...0.5),
//                                        blue: .random(in: 0...0.5)
//                                    )
//                                )
//                                .cornerRadius(60)
//                            
//                        }
//                    })
//                }
                
                /// HStack qui affiche la date de sortie et la durée du film
                HStack(alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/, spacing: screenSize.width/20, content: {
                    Text(getTodayDateLocale())
                        .font(.subheadline)
                        .fontWeight(.light)
                    
                    if(movie.runtime != nil) {
                        Text("-")
                            .font(.subheadline)
                            .fontWeight(.light)
                        
                        Text(getTimeFormatted(time: movie.runtime!))
                            .font(.subheadline)
                            .fontWeight(.light)
                    }
                })
            }).frame(
                minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/,
                maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/,
                alignment: .top)
            
            VStack(content: {
                Divider()
            }).frame(width: screenSize.width/1.1, height: screenSize.height/50, alignment:.center)
            
            /// VStack et ScrollView du résumé du film
            VStack(alignment: .leading, spacing: screenSize.height/40, content: {
                Text("Synopsis")
                    .font(.title3)
                    .fontWeight(.medium)
                if(movie.overview != nil) {
                    ScrollView(content: {
                        Text(movie.overview!)
                            .font(.body)
                            .fontWeight(.regular)
                            .lineLimit(nil)
                    })
                }
            }).frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, maxWidth: screenSize.width/1.1, maxHeight: screenSize.height/5.8, alignment: .topLeading)
            
            VStack(content: {
                Divider()
            }).frame(width: screenSize.width/1.1, height: screenSize.height/40, alignment:.center)
            
            /// VStack contenant le bouton et le lien de la vidéo YouTube & l'ajout à la liste
            VStack(alignment: .trailing, content: {
                /// On vérifie que la clef de la vidéo est bien présente
                //                    if (movie.hasVideo)
                //                    {
                //                        /// On vérifie que la création de l'URL est correcte
                //                        if let videoUrl = URL(string: K.youtubeURL + video_key) {
                //                            Button(action: {  UIApplication.shared.open(videoUrl, options: [:], completionHandler: nil)}, label: {
                //                                Image(systemName: "play.circle").resizable().aspectRatio(contentMode: .fit).frame(width: screenSize.width/7)})
                //                        } else {
                //                            Text("Une erreur est survenue")
                //                        }
                //                    } else {Text("Aucun vidéo disponible")}
                Button(action: {
                    addMovieToFavorites()
                }, label: {
                    HStack {
                        Image(systemName: "plus.app.fill")
                            .resizable()
                            .foregroundColor(.black)
                            .frame(width: 30, height: 30, alignment: .center)
                    }.alert("Le film a bien été ajouté à vos favoris", isPresented: $showingValidAlert) {
                        Button("OK", role: .cancel) {
                            self.showingValidAlert = false
                        }
                    }.alert("Vous avez déjà le film dans vos favoris", isPresented: $showingErrorAlert) {
                        Button("OK", role: .cancel) {
                            self.showingErrorAlert = false
                        }
                    }
                })
            }).frame(width: screenSize.width, height: screenSize.height/10, alignment: .top)
        })
        .ignoresSafeArea()
    }
}
