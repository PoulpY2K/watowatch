//
//  MovieList.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 15/03/2024.
//

import Foundation
import SwiftData

@Model
final class MovieList {
    var name: String
    var movies: [Movie]
    
    init(name: String, movies: [Movie]) {
        self.name = name
        self.movies = movies
    }
}

extension MovieList: Identifiable {}

