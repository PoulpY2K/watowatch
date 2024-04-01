//
//  FeedState.swift
//  UnsplashApp
//
//  Created by Jérémy Laurent on 02/02/2024.
//

import Foundation

class FeedState: ObservableObject {
    @Published var homeFeed: [Movie]?

    // Fetch home feed doit utiliser la fonction feedUrl de UnsplashAPI
    // Puis assigner le résultat de l'appel réseau à la variable homeFeed
    func fetchHomeFeed() async {
            do {
                // Créez une requête avec cette URL
                if let url = TMDBService().feedDiscoverMovieUrl(includeAdult: "true", includeVideo: "true") {
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
}
