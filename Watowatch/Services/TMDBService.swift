//
//  MovieService.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 05/04/2022.
//

import Foundation

class TMDBService {
    let baseUrl: String = "https://api.themoviedb.org/3"
    let scheme: String = "https"
    let host: String = "api.themoviedb.org/3"
    let apiKeyQueryParam: String = "api_key"
    
    let moviePath: String = "/movie"
    let genrePath: String = "/genre"
    let discoverPath: String = "/discover"
    
    /// Permet de construire l'URL de base de TMDB
    func tmdbApiBaseUrl() -> URLComponents {
        var components = URLComponents()
        let apiKeyQueryItem = URLQueryItem(name: apiKeyQueryParam, value: ConfigurationManager.instance.plistDictionnary.apiKey)
        
        components.scheme = scheme
        components.host = host
        components.queryItems = [apiKeyQueryItem]
        
        return components
    }
    
    /// Permet de découvrir des films avec une variété de filtres
    func feedDiscoverMovieUrl(language: String = "fr-FR", sortBy: String? = "popularity.desc", withGenresId: String? = nil, includeAdult: String? = "false", includeVideo: String? = "false") -> URL? {
        var components = tmdbApiBaseUrl()
        components.path += discoverPath + moviePath
        
        let languageQueryItem = URLQueryItem(name: "language", value: language)
        let sortByQueryItem = URLQueryItem(name: "sort_by", value: sortBy)
        let includeAdultQueryItem = URLQueryItem(name: "include_adult", value: includeAdult)
        let includeVideoQueryItem = URLQueryItem(name: "include_video", value: includeVideo)
        let genresIdQueryItem = URLQueryItem(name: "with_genres", value: withGenresId ?? "")
        
        if components.queryItems != nil {
            components.queryItems! += [languageQueryItem, sortByQueryItem, includeAdultQueryItem, includeVideoQueryItem]
        }
        
        return components.url
    }
}
