//
//  MovieInfo.swift
//  BoxOffice
//
//  Created by dhoney96 on 2023/01/03.
//

import Foundation
//MARK: 영화 상세 정보 DTO
struct MovieInfoResult: Decodable {
    let movieInfoResult: MovieInfo
}

struct MovieInfo: Decodable {
    let movieInfo: DetailInfo
}

struct DetailInfo: Decodable {
    let movieNmEn: String
    let prdtYear: String
    let openDt: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let audits: [Audit]
    let showTm: String
}

struct Nation: Decodable {
    let nationNm: String
}

struct Genre: Decodable {
    let genreNm: String
}

struct Director: Decodable {
    let peopleNm: String
}

struct Actor: Decodable {
    let peopleNm: String
    let cast: String
}

struct Audit: Decodable {
    let watchGradeNm: String
}
