//
//  PosterDTO.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/05.
//

import Foundation

struct PosterDTO: Decodable {
    let posterURL: String
    enum CodingKeys: String, CodingKey {
        case posterURL = "Poster"
    }
}
