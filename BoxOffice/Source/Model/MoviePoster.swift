//
//  MoviePoster.swift
//  BoxOffice
//
//  Created by dhoney96 on 2023/01/03.
//

import Foundation
//MARK: poster
struct MoviePoster: Decodable {
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case poster = "Poster"
    }
}
