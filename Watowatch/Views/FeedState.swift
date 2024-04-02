//
//  FeedState.swift
//  UnsplashApp
//
//  Created by Jérémy Laurent on 02/02/2024.
//

import Foundation

class FeedState: ObservableObject {
    @Published var homeFeed: [Movie]?
    @Published var genreFeed: [Genre]?
    
    func fetchHomeFeed() async {
        do {
            // Créez une requête avec cette URL
            if let url = TMDBService().feedDiscoverUrl(includeAdult: "true", includeVideo: "true") {
                let request = URLRequest(url: url)
                
                // Faites l'appel réseau
                let (data, _) = try await URLSession.shared.data(for: request)
                
                // Transformez les données en JSON
                let deserializedData = try JSONDecoder().decode(MoviePageableList.self, from: data).results
                
                // Mettez à jour l'état de la vue
                homeFeed = deserializedData
            }
        } catch {
            print("Error: \(error)")
        }
    }
    
    func fetchGenreFeed() async {
        do {
            if let url = TMDBService().feedGenreUrl() {
                let request = URLRequest(url: url)
                let (data, _) = try await URLSession.shared.data(for: request)
                let deserializedData = try JSONDecoder().decode(GenreListResult.self, from: data).genres
                genreFeed = deserializedData
            }
        } catch {
            print("Error: \(error)")
        }
        
    }
    
    func fetchByGenre(genres: String = "") async -> [Movie]? {
        do {
            print(genres)
            // Créez une requête avec cette URL
            if let url = TMDBService().feedDiscoverUrl(withGenresId: genres, includeAdult: "true", includeVideo: "true") {
                let request = URLRequest(url: url)
                let (data, _) = try await URLSession.shared.data(for: request)
                let deserializedData = try JSONDecoder().decode(MoviePageableList.self, from: data).results
                return deserializedData
            }
        } catch {
            print("Error: \(error)")
        }
        return nil
    }
}
