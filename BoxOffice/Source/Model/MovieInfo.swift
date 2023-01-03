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
    let movieNmEn: String // 영화 이름(영어)
    let prdtYear: String // 제작 년도
    let openDt: String // 개봉 년도
    let genres: [Genre] // 장르
    let directors: [Director] // 감독
    let actors: [Actor] // 배우
    let audits: [Audit] // 관람등급
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
