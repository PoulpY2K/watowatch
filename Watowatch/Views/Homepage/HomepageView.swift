//
//  HomepageView.swift
//  Watowatch
//
//  Created by Stéphane Humblot on 15/03/2024.
//

import SwiftUI

struct HomepageView: View {

    // @TODO: use proper data
    let cards : [MovieCard] = [MovieCard(), MovieCard(), MovieCard()]
    let movies: [String] = ["Film 1", "Film 2", "Film 3"]
    let filters: [String] = ["Films", "Séries", "Animes"]

    @StateObject var feedState = FeedState()
    @State var carouselHeight: CGFloat = 0
    @State var selectedFilters: [String] = []
    @State var selectedMovie: Movie? = nil

    var body: some View {
        NavigationStack {
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
                }.padding(.bottom)
                GeometryReader { reader in
                    ScrollView {

                        Text("Bonjour, XXX") // @TODO: use stored name
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .padding(.bottom, 20)


                        let width = reader.size.width
                        MovieCardCarousel(
                            cards: cards,
                            height: carouselHeight,
                            width: width
                        ).frame(height: carouselHeight)
                            .cornerRadius(40)

                            .padding(.bottom, 16)
                            .onAppear() {
                                carouselHeight = reader.size.width * 1.5
                            }

                        HStack {
                            ForEach(filters, id: \.self) { filter in
                                let isSelected = selectedFilters.contains(filter)
                                SelectButton(isSelected: isSelected , color: .purple, text: filter)
                                    .onTapGesture {
                                        if let index = selectedFilters.firstIndex(of: filter) {
                                            selectedFilters.remove(at: index)
                                        } else {
                                            selectedFilters.append(filter)
                                        }
                                    }
                            }
                        }.frame(maxWidth: 400)
                            .padding(.bottom)


                        Text("Action")
                            .frame(maxWidth: .infinity, alignment: .leading)
                        ScrollView(.horizontal) {
                            HStack {
                                if(feedState.homeFeed != nil) {
                                    ForEach(feedState.homeFeed!, id: \.id) { movie in
                                        Button(action: {
                                            self.selectedMovie = movie
                                        }) {
                                            ZStack {
                                                AsyncImage(url:
                                                            TMDBService().getImageUrl(path: movie.backdropPath?.absoluteString ?? "")
                                                ) { image in
                                                    image
                                                        .resizable()
                                                        .aspectRatio(contentMode: .fill)
                                                        .frame(width: 100, height: 100)
                                                        .clipShape(RoundedRectangle(cornerRadius: 10))
                                                } placeholder: {
                                                    RoundedRectangle(cornerRadius: 10)
                                                        .frame(width: 100, height: 100)
                                                }

                                                Text(movie.title).foregroundColor(.white).frame(width: 100, height: 100).fixedSize(horizontal: true, vertical: false).bold()
                                            }
                                        }
                                        .sheet(item: self.$selectedMovie) {selectedMovie in
                                            DetailSheetView(movie: selectedMovie)
                                        }
                                    }
                                }
                            }
                        }.scrollIndicators(.hidden)

                    }.scrollIndicators(.hidden)
                }
            }
        }
        .padding(.horizontal, 20)
        .onAppear() {
            Task {
                await feedState.fetchHomeFeed()
            }
        }
    }
}

#Preview {
    HomepageView()
}
