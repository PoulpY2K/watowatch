//
//  UserList.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 01/04/2024.
//

import Foundation
import SwiftData

@Model
public class UserList: Identifiable, Equatable, Hashable {
    ///
    /// Language code.
    ///
    public var id: String { name }

    ///
    /// Name of the userList
    ///
    @Attribute(.unique) public var name: String
    
    ///
    /// List of movies
    ///
    public var movies: [Movie]
    
    ///
    /// List thumbnail URL
    ///
    public var thumbnailURL: String
    
    public init(name: String, movies: [Movie], thumbnailURL: String) {
        self.name = name
        self.movies = movies
        self.thumbnailURL = thumbnailURL
    }
}
