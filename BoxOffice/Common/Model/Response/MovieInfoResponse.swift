//
//  MovieInfoResponse.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/22.
//

import Foundation

struct MovieInfoResultResponse: Codable {
    let movieInfoResult: MovieInfo
}

struct MovieInfo: Codable {
    let movieInfo: MovieInfoResponse
}

struct MovieInfoResponse: Codable {
    /// 제작연도
    let prdtYear: String
    /// 상영시간
    let showTm: String
    /// 장르
    let genres: [Genres]
    /// 감독
    let directors: [Directors]
    /// 배우
    let actors: [Actors]
    /// 관람등급
    let audits: [Audits]
}

struct Genres: Codable {
    /// 장르명
    let genreNm: String
}

struct Directors: Codable {
    /// 감독명
    let peopleNm: String
}

struct Actors: Codable {
    /// 배우명
    let peopleNm: String
}

struct Audits: Codable {
    /// 관람등급명
    let watchGradeNm: String
}
