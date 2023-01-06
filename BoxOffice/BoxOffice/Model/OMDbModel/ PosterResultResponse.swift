//
//  PosterResultResponse.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/04.
//

import Foundation

struct PosterResultResponse: Decodable {
    let poster: String
    let title: String

    private enum CodingKeys: String, CodingKey {
        case poster = "Poster"
        case title = "Title"
    }
}

struct CustomBoxOffice: Hashable {
    let boxOffice: BoxOfficeMovie
    let posterURL: String
}
