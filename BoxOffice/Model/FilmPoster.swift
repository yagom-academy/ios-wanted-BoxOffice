//
//  FilmPoster.swift
//  BoxOffice
//
//  Created by 천승희 on 2023/01/03.
//

import Foundation

struct FilmPoster: Decodable {
    let search: [Search]
}

struct Search: Decodable {
    let poster: String
}
