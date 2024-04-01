//
//  ListView.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 01/04/2024.
//

import SwiftUI
import SwiftData

struct ListView: View {
    // MARK: - PROPERTIES
    @Query var movieList: [Movie]
    
    // MARK: - BODY
    var body: some View {
            VStack {
                if (!movieList.isEmpty) {
                    List(movieList) { movie in
                        Text(movie.title)
                    }
                } else {
                    Text("Aucun film n'a été ajouté.")
                }
            }
        .navigationTitle("Favoris")
    }
}
