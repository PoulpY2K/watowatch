//
//  ListView.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 01/04/2024.
//

import SwiftUI
import SwiftData
import Charts

struct ListView: View {
    // MARK: - PROPERTIES
    @Environment(\.modelContext) private var modelContext
    @Query var movieList: [Movie]
    @State var chartMovies = [String : Int]()
    
    // MARK: - BODY
    var body: some View {
        VStack {
            if (!movieList.isEmpty) {
                Chart(movieList) { movie in
                    SectorMark(
                        angle: .value(
                            Text(verbatim: movie.title), 0.5
                        ),
                        innerRadius: .ratio(0.6)
                    )
                    .foregroundStyle(by: .value(Text(String(movie.releaseDate!)), movie.releaseDate!))
                }.frame(maxWidth: .infinity, maxHeight: 250)
                    .padding()
                
                List(movieList) { movie in
                    NavigationLink {
                        DetailSheetView(movie: movie)
                    } label: {
                        VStack {
                            Text(movie.title)
                            if(movie.originalTitle != nil) {
                                Text(movie.originalTitle!).font(.footnote)
                            }
                        }
                    }
                }
            } else {
                Text("Aucun film n'a été ajouté.")
            }
        }
        .navigationTitle("Favoris")
    }
}
