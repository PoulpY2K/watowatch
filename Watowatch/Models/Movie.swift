//
//  Movie.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 15/03/2024.
//

import Foundation
import SwiftData

///
/// A model representing a movie.
///

@Model
final public class Movie: Identifiable, Codable, Equatable, Hashable {
    
    ///
    /// Movie identifier.
    ///
    public var id: Int
    
    ///
    /// Movie title.
    ///
    public var title: String
    
    ///
    /// Movie tagline.
    ///
    public var tagline: String?
    
    ///
    /// Original movie title.
    ///
    public var originalTitle: String?
    
    ///
    /// Original language of the movie.
    ///
    public var originalLanguage: String?
    
    ///
    /// Movie overview.
    ///
    public var overview: String?
    
    ///
    /// Movie runtime, in minutes.
    ///
    public var runtime: Int?
    
    ///
    /// Movie genres.
    ///
    public var genres: [Genre]?
    
    ///
    /// Movie release date.
    ///
    public var releaseDate: String?
    
    ///
    /// Movie poster path.
    ///
    /// To generate a full URL see <doc:/TMDb/GeneratingImageURLs>.
    ///
    public var posterPath: URL?
    
    ///
    /// Movie poster backdrop path.
    ///
    /// To generate a full URL see <doc:/TMDb/GeneratingImageURLs>.
    ///
    public var backdropPath: URL?
    
    ///
    /// Movie budget, in US dollars.
    ///
    public var budget: Double?
    
    ///
    /// Movie revenue, in US dollars.
    ///
    public var revenue: Double?
    
    ///
    /// Movie's web site URL.
    ///
    public var homepageURL: URL?
    
    ///
    /// IMDd identifier.
    ///
    public var imdbID: String?
    
    ///
    /// Current popularity.
    ///
    public var popularity: Double?
    
    ///
    /// Average vote score.
    ///
    public var voteAverage: Double?
    
    ///
    /// Number of votes.
    ///
    public var voteCount: Int?
    
    ///
    /// Has video.
    ///
    public var hasVideo: Bool?
    
    ///
    /// Is the movie only suitable for adults.
    ///
    public var isAdultOnly: Bool?
    
    ///
    /// Creates a movie object.
    ///
    /// - Parameters:
    ///    - id: Movie identifier.
    ///    - title: Movie title.
    ///    - tagline: Movie tagline.
    ///    - originalTitle: Original movie title.
    ///    - originalLanguage: Original language of the movie.
    ///    - overview: Movie overview.
    ///    - runtime: Movie runtime, in minutes.
    ///    - genres: Movie genres.
    ///    - releaseDate: Movie release date.
    ///    - posterPath: Movie poster path.
    ///    - backdropPath: Movie poster backdrop path.
    ///    - budget: Movie budget, in US dollars.
    ///    - revenue: Movie revenue, in US dollars.
    ///    - homepageURL: Movie's web site URL.
    ///    - imdbID: IMDd identifier.
    ///    - status: Movie status.
    ///    - popularity: Current popularity.
    ///    - voteAverage: Average vote score.
    ///    - voteCount: Number of votes.
    ///    - hasVideo: Has video.
    ///    - isAdultOnly: Is the movie only suitable for adults.
    ///
    public init(
        id: Int,
        title: String,
        tagline: String? = nil,
        originalTitle: String? = nil,
        originalLanguage: String? = nil,
        overview: String? = nil,
        runtime: Int? = nil,
        genres: [Genre]? = nil,
        releaseDate: String? = nil,
        posterPath: URL? = nil,
        backdropPath: URL? = nil,
        budget: Double? = nil,
        revenue: Double? = nil,
        homepageURL: URL? = nil,
        imdbID: String? = nil,
        popularity: Double? = nil,
        voteAverage: Double? = nil,
        voteCount: Int? = nil,
        hasVideo: Bool? = nil,
        isAdultOnly: Bool? = nil
    ) {
        self.id = id
        self.title = title
        self.tagline = tagline
        self.originalTitle = originalTitle
        self.originalLanguage = originalLanguage
        self.overview = overview
        self.runtime = runtime
        self.genres = genres
        self.releaseDate = releaseDate
        self.posterPath = posterPath
        self.backdropPath = backdropPath
        self.budget = budget
        self.revenue = revenue
        self.homepageURL = homepageURL
        self.imdbID = imdbID
        self.popularity = popularity
        self.voteAverage = voteAverage
        self.voteCount = voteCount
        self.hasVideo = hasVideo
        self.isAdultOnly = isAdultOnly
    }
    
    private enum CodingKeys: String, CodingKey {
        case id
        case title
        case tagline
        case originalTitle
        case originalLanguage
        case overview
        case runtime
        case genres
        case releaseDate = "release_date"
        case posterPath = "poster_path"
        case backdropPath = "backdrop_path"
        case budget
        case revenue
        case homepageURL = "homepage"
        case imdbID = "imdbId"
        case popularity
        case voteAverage
        case voteCount
        case hasVideo = "video"
        case isAdultOnly = "adult"
    }
    
    required public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let container2 = try decoder.container(keyedBy: CodingKeys.self)
        
        self.id = try container.decode(Int.self, forKey: .id)
        self.title = try container.decode(String.self, forKey: .title)
        self.tagline = try container.decodeIfPresent(String.self, forKey: .tagline)
        self.originalTitle = try container.decodeIfPresent(String.self, forKey: .originalTitle)
        self.originalLanguage = try container.decodeIfPresent(String.self, forKey: .originalLanguage)
        self.overview = try container.decodeIfPresent(String.self, forKey: .overview)
        self.runtime = try container.decodeIfPresent(Int.self, forKey: .runtime)
        self.genres = try container.decodeIfPresent([Genre].self, forKey: .genres)
        
        // Need to deal with empty strings - date decoding will fail with an empty string
        let releaseDateString = try container.decodeIfPresent(String.self, forKey: .releaseDate)
        self.releaseDate = try {
            guard let releaseDateString, !releaseDateString.isEmpty else {
                return ""
            }
            
            return try container2.decodeIfPresent(String.self, forKey: .releaseDate)
        }()
        
        self.posterPath = try container.decodeIfPresent(URL.self, forKey: .posterPath)
        self.backdropPath = try container.decodeIfPresent(URL.self, forKey: .backdropPath)
        self.budget = try container.decodeIfPresent(Double.self, forKey: .budget)
        self.revenue = try container.decodeIfPresent(Double.self, forKey: .revenue)
        
        // Need to deal with empty strings - URL decoding will fail with an empty string
        let homepageURLString = try container.decodeIfPresent(String.self, forKey: .homepageURL)
        self.homepageURL = try {
            guard let homepageURLString, !homepageURLString.isEmpty else {
                return nil
            }
            
            return try container2.decodeIfPresent(URL.self, forKey: .homepageURL)
        }()
        
        self.imdbID = try container.decodeIfPresent(String.self, forKey: .imdbID)
        self.popularity = try container.decodeIfPresent(Double.self, forKey: .popularity)
        self.voteAverage = try container.decodeIfPresent(Double.self, forKey: .voteAverage)
        self.voteCount = try container.decodeIfPresent(Int.self, forKey: .voteCount)
        self.hasVideo = try container.decodeIfPresent(Bool.self, forKey: .hasVideo)
        self.isAdultOnly = try container.decodeIfPresent(Bool.self, forKey: .isAdultOnly)
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = try encoder.container(keyedBy: CodingKeys.self)
        
        try container.encode(id, forKey: .id)
        try container.encode(title, forKey: .title)
        try container.encode(tagline, forKey: .tagline)
        try container.encode(originalTitle, forKey: .originalTitle)
        try container.encode(originalLanguage, forKey: .originalLanguage)
        try container.encode(overview, forKey: .overview)
        try container.encode(runtime, forKey: .runtime)
        try container.encode(genres, forKey: .genres)
        try container.encode(releaseDate, forKey: .releaseDate)
        try container.encode(posterPath, forKey: .posterPath)
        try container.encode(backdropPath, forKey: .backdropPath)
        try container.encode(budget, forKey: .budget)
        try container.encode(revenue, forKey: .revenue)
        try container.encode(homepageURL, forKey: .homepageURL)
        try container.encode(imdbID, forKey: .imdbID)
        try container.encode(popularity, forKey: .popularity)
        try container.encode(voteAverage, forKey: .voteAverage)
        try container.encode(voteCount, forKey: .voteCount)
        try container.encode(hasVideo, forKey: .hasVideo)
        try container.encode(isAdultOnly, forKey: .isAdultOnly)
    }
}
