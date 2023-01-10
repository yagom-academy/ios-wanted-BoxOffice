//
//  MoviePoster.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/03.
//

import Foundation

struct MoviePoster: Decodable {
    let poster: String?
    let title: String?
    
    enum CodingKeys: String, CodingKey {
        case poster = "Poster"
        case title = "Title"
    }
}
