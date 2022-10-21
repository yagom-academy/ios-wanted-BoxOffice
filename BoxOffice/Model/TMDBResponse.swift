//
//  TMDBResponse.swift
//  BoxOffice
//
//  Created by sole on 2022/10/21.
//

import Foundation

struct TMDBResponse: Decodable {
    let results: [TmdbAsset]?
}

struct TmdbAsset: Decodable {
    let id: Int
    let backdropPath: String
    let posterPath: String
    let plot: String

    enum CodingKeys: String, CodingKey {
        case id
        case backdropPath = "backdrop_path"
        case posterPath = "poster_path"
        case plot = "overview"
    }
}

struct TmdbTrailerResponse: Decodable {
    let result: TmdbTrailer

    enum CodingKeys: String, CodingKey {
        case result = "videos"
    }
}

struct TmdbTrailer: Decodable {
    let trailer: [Trailer]
    
    enum CodingKeys: String, CodingKey {
        case trailer = "results"
    }
}

struct Trailer: Decodable {
    let key: String
    let site: String
}
