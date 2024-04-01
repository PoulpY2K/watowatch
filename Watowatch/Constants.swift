//
//  Constants.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 01/04/2024.
//

import Foundation

/// Constantes de l'application
struct K {
    static let movieApiBaseUrl: String = "https://api.themoviedb.org/3/movie"
    static let movieApiPerGenreUrl: String = "\(movieApiBaseUrl)/popular?language=fr-FR&with_genres="
    
    static let genreApiBaseUrl: String = "https://api.themoviedb.org/3/genre"
    static let genresListUrl: String = "\(genreApiBaseUrl)/movie/list?language=fr-FR"
    
    static let discoverApiBaseUrl: String = "https://api.themoviedb.org/3/discover"
    
    static let TMDBImageURL: String = "https://image.tmdb.org/t/p/original"
    static let youtubeURL: String = "https://www.youtube.com/watch?v="
}
