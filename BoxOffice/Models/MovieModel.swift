//
//  MovieModel.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/19.
//

import Foundation

// MARK: - Kobis API JSON Response

struct DailyBoxOfficeResult: Codable {
  let boxOfficeResult: DailyResult
}

struct DailyResult: Codable {
  let boxofficeType: String
  let showRange: String
  let dailyBoxOfficeList: [DailyListObject]
}

struct DailyListObject: Codable {
  let rank: String
  let rankInten: String
  let rankOldAndNew: String
  let movieCd: String
  let movieNm: String
  let openDt: String
  let audiCnt: String
}

struct MovieDetailResult: Codable {
  let movieInfoResult: MovieInfoObject
}

struct MovieInfoObject: Codable {
  let movieInfo: MovieInfo
}

struct MovieInfo: Codable {
  let movieNmEn: String
  let prdtYear: String
  let showTm: String
  let genres: [Genre]
  let directors: [Director]
  let actors: [Actor]
  let audits: [Audit]
}

struct Genre: Codable {
  let genreNm: String
}

struct Director: Codable {
  let peopleNm: String
}

struct Actor: Codable {
  let peopleNm: String
  let cast: String
}

struct Audit: Codable {
  let watchGradeNm: String
}

// MARK: - OMDb API JSON Response

struct OMDbResult: Codable {
  let Poster: String
}
