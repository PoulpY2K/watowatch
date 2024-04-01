//
//  Genre.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 15/03/2024.
//

import Foundation
import SwiftData

///
/// A model representing a genre.
///

@Model
public struct GenreModel: Identifiable, Hashable {

    ///
    /// Genre Identifier.
    ///
    public let id: Int

    ///
    /// Genre name.
    ///
    public let name: String

    ///
    /// Creates a genre object.
    ///
    /// - Parameters:
    ///    - id: Genre Identifier.
    ///    - name: Genre name.
    ///
    public init(id: Int, name: String) {
        self.id = id
        self.name = name
    }

}
