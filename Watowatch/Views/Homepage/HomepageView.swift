//
//  HomepageView.swift
//  Watowatch
//
//  Created by Stéphane Humblot on 15/03/2024.
//

import SwiftUI

struct HomepageView: View {
    @StateObject var feedState = FeedState()
    @State var carouselHeight: CGFloat = 400
    @State var selectedFilters: [String] = []
    @State var selectedMovie: Movie? = nil
    @State var movies: [Movie] = []
    @State var seeMore: Bool = false
    
    var body: some View {
        VStack {
            HStack () {
                NavigationLink {
                    ListView()
                } label: {
                    Image(systemName: "person.crop.circle")
                        .imageScale(.large)
                        .foregroundColor(.black)
                }
                Spacer()
                Button(action: /*@START_MENU_TOKEN@*/{}/*@END_MENU_TOKEN@*/, label: {
                    Image(systemName: "magnifyingglass.circle")
                        .imageScale(.large)
                        .foregroundColor(.black)
                })
            }.padding(.bottom).padding(.horizontal, 20)
            
            ScrollView {
                Text("Bonjour,")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.bottom, 20).padding(.horizontal, 20)
                
                if(feedState.homeFeed != nil) {
                    MovieCardCarousel(
                        cards: feedState.homeFeed![0..<3].map {MovieCard(movie: $0)},
                        height: carouselHeight,
                        width: 250
                    ).frame(width: 400, height: carouselHeight)
                        .padding(.bottom, 20)
                } else {
                    RoundedRectangle(cornerRadius: 20)
                        .fill(.gray)
                        .frame(width: 350, height: carouselHeight)
                        .padding(.bottom, 20)
                }
                
                if feedState.genreFeed != nil {
                    let limit = !seeMore ? 3 : feedState.genreFeed!.count
                    ForEach(feedState.genreFeed![0..<limit], id: \.id) { genre in
                        LazyVStack {
                            Text(genre.name)
                                .frame(maxWidth: .infinity, alignment: .leading).padding(.horizontal, 20)
                            ScrollView(.horizontal) {
                                HStack {
                                    ForEach(movies, id: \.id) { movie in
                                        VStack {
                                            AsyncImage(url: TMDBService().getImageUrl(path: movie.backdropPath?.absoluteString ?? "")) { image in
                                                image
                                                    .resizable()
                                                    .aspectRatio(contentMode: .fill)
                                                    .frame(width: 100, height: 100)
                                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                            } placeholder: {
                                                RoundedRectangle(cornerRadius: 10)
                                                    .fill(.gray)
                                                    .frame(width: 100, height: 100)
                                            }.onTapGesture {
                                                self.selectedMovie = movie
                                            }
                                            
                                            Text(movie.title)
                                                .font(.system(size: 14))
                                                .foregroundColor(.black)
                                                .frame(width: 100, height: 16, alignment: .leading)
                                                .fixedSize(horizontal: true, vertical: false)
                                        }
                                    }
                                }.padding(.bottom)
                                    .onAppear() {
                                        Task {
                                            movies = await feedState.fetchByGenre(genres: String(genre.id)) ?? []
                                        }
                                    }
                            }
                        }.contentMargins(.leading, 20)
                    }
                    if !seeMore {
                        Button(action: {
                            seeMore = true
                        }, label: {Text("Voir Plus...")})
                        .padding(.top)
                    }
                }
            }.scrollIndicators(.hidden)
        }
        .onAppear() {
            Task {
                await feedState.fetchHomeFeed()
                await feedState.fetchGenreFeed()
            }
        }.sheet(item: self.$selectedMovie) {selectedMovie in
            DetailSheetView(movie: selectedMovie)
        }
    }
}

