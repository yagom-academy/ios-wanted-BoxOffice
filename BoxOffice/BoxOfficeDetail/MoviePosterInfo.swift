//
//  MoviePosterInfo.swift
//  BoxOffice
//
//  Created by 백곰 on 2023/01/04.
//
import Foundation

// MARK: - MoviePosterInfo
struct MoviePosterInfo: Codable {
    let search: [Search]
    let totalResults, response: String

    enum CodingKeys: String, CodingKey {
        case search = "Search"
        case totalResults
        case response = "Response"
    }
}

// MARK: - Search
struct Search: Codable {
    let title, year, imdbID, type: String
    let poster: String

    enum CodingKeys: String, CodingKey {
        case title = "Title"
        case year = "Year"
        case imdbID
        case type = "Type"
        case poster = "Poster"
    }
}
