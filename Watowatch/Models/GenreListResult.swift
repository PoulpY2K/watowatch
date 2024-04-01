//
//  GenreListResult.swift
//  Watowatch
//
//  Created by m1 on 01/04/2024.
//

import Foundation

public struct GenreListResult: Codable, Equatable, Hashable {
    public let genres: [Genre]

    public init(
        genres: [Genre]
    ) {
        self.genres = genres
    }

    public enum CodingKeys: String, CodingKey {
        case genres = "genres"
    }
}
