//
//  MovieService.swift
//  MoviesLive
//
//  Created by Jérémy Laurent on 05/04/2022.
//

import Foundation

class TMDBService {
    let baseUrl: String = "https://api.themoviedb.org"
    let scheme: String = "https"
    let host: String = "api.themoviedb.org"
    let imageHost: String = "image.tmdb.org"
    let apiKeyQueryParam: String = "api_key"
    
    let imagePath: String = "/t/p/original"
    let moviePath: String = "/3/movie"
    let genrePath: String = "/3/genre"
    let discoverPath: String = "/3/discover"
    
    /// Permet de construire l'URL de base de TMDB
    func tmdbApiBaseUrl() -> URLComponents {
        var components = URLComponents()
        
        components.scheme = scheme
        components.host = host
        components.queryItems = [URLQueryItem(name: apiKeyQueryParam, value: ConfigurationManager.instance.plistDictionnary.apiKey)]
        
        return components
    }
    
    func tmdbImageBaseUrl() -> URLComponents {
        var components = URLComponents()
        
        components.scheme = scheme
        components.host = imageHost
        
        return components
    }
    
    /// Permet de découvrir des films avec une variété de filtres
    func feedDiscoverUrl(language: String = "fr-FR", sortBy: String? = "popularity.desc", withGenresId: String? = nil, includeAdult: String? = "false", includeVideo: String? = "false") -> URL? {
        var components = tmdbApiBaseUrl()
        components.path += "\(discoverPath)/movie"
        
        let languageQueryItem = URLQueryItem(name: "language", value: language)
        let sortByQueryItem = URLQueryItem(name: "sort_by", value: sortBy)
        let includeAdultQueryItem = URLQueryItem(name: "include_adult", value: includeAdult)
        let includeVideoQueryItem = URLQueryItem(name: "include_video", value: includeVideo)
        
        components.queryItems! += [languageQueryItem, sortByQueryItem, includeAdultQueryItem, includeVideoQueryItem]

        if withGenresId != nil {
            components.queryItems! += [URLQueryItem(name: "with_genres", value: withGenresId ?? "")]
        }
        
        return components.url
    }
    
    func getImageUrl(path: String) -> URL? {
        var components = tmdbImageBaseUrl()
        components.path += "\(imagePath)\(path)"
        return components.url
    }

    func feedGenreUrl(language: String = "fr-FR") -> URL? {
        var components = tmdbApiBaseUrl()
        components.path += "\(genrePath)/movie/list"
        components.queryItems! += [URLQueryItem(name: "language", value: language)]
        return components.url
    }
}
