//
//  FilmDetails.swift
//  BoxOffice
//
//  Created by 천승희 on 2023/01/03.
//

import Foundation

struct FilmDetails: Decodable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Decodable {
    let movieInfo: MovieInfo
}

struct MovieInfo: Decodable {
    let prdtYear: String
    let openDt: String
    let showTm: String
    let genres: [Genres]
    let directors: [PeopleName]
    let actors: [PeopleName]
    let audits: [Audits]
}
