//
//  MoviePosterResponse.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation

struct MoviePosterResponse: Codable {
    
    let response: String
    let poster: String?
    
    private enum CodingKeys: String, CodingKey {
        case response = "Response"
        case poster = "Poster"
    }
    
}
