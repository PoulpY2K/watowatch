//
//  PageableListResult.swift
//  Watowatch
//
//  Created by Jérémy Laurent on 01/04/2024.
//

import Foundation

///
/// A model representing a pageable list of items.
///
public struct PageableListResult<Result: Codable & Identifiable & Equatable & Hashable>: Codable, Equatable, Hashable {

    ///
    /// Page number.
    ///
    public let page: Int?

    ///
    /// Results for this page of a list.
    ///
    public let results: [Result]

    ///
    /// Total results.
    ///
    public let totalResults: Int?

    ///
    /// Total pages.
    ///
    public let totalPages: Int?

    ///
    /// Creates a pageable list result object.
    ///
    /// - Parameters:
    ///    - page: Page number.
    ///    - results: Results for this page of a list.
    ///    - totalResults: Total results.
    ///    - totalPages: Total pages.
    ///
    public init(
        page: Int? = 1,
        results: [Result],
        totalResults: Int? = 0,
        totalPages: Int? = 0
    ) {
        self.page = page
        self.results = results
        self.totalResults = totalResults
        self.totalPages = totalPages
    }

    public enum CodingKeys: String, CodingKey {
        case page = "page"
        case results = "results"
        case totalResults = "total_results"
        case totalPages = "total_pages"
    }
}
