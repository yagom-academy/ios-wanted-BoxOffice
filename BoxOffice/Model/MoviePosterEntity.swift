//
//  MovieEntity.swift
//  BoxOffice
//
//  Created by 이은찬 on 2023/01/03.
//

import Foundation

struct MoviePosterEntity: Decodable {
    let poster: String
    
    enum CodingKeys: String, CodingKey {
        case poster = "Poster"
    }
}
