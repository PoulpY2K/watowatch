//
//  VideoMetadata.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 01/04/2024.
//

import Foundation

///
/// A model representing details of a video.
///
public struct VideoMetadata: Identifiable, Codable, Equatable, Hashable {

    ///
    /// Video identifier.
    ///
    public let id: String

    ///
    /// Video name.
    ///
    public let name: String

    ///
    /// Site which the video is from.
    ///
    public let site: String

    ///
    /// Site's video identifier.
    ///
    public let key: String

    ///
    /// Creates a video metadata object.
    ///
    /// - Parameters:
    ///    - id: Video identifier.
    ///    - name: Video name.
    ///    - site: Site which the video is from.
    ///    - key: Site's video identifier.
    ///
    public init(
        id: String,
        name: String,
        site: String,
        key: String
    ) {
        self.id = id
        self.name = name
        self.site = site
        self.key = key
    }

}
