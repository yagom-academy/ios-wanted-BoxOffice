//
//  MovieModel.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/19.
//

import Foundation

// MARK: - Kobis API JSON Response

struct DailyBoxOfficeResult {
  let boxofficeType: String
  let showRange: String
  let daliyBoxOfficeList: [DailyListObject]
}

struct DailyListObject {
  let rank: String
  let rankInten: String
  let rankOldAndNew: String
  let movieCd: String
  let movieNm: String
  let openDt: String
  let audiCnt: String
}

struct MovieDetailResult {
  let movieInfoResult: MovieInfo
}

struct MovieInfo {
  let prdYear: String
  let showTm: String
  let genres: Genre
  let directors: [Director]
  let actors: [Actor]
  let audits: Audit
}

struct Genre {
  let genreNm: String
}

struct Director {
  let peopleNm: String
}

struct Actor {
  let peopleNm: String
  let cast: String
}

struct Audit {
  let watchGradeNm: String
}

// MARK: - OMDb API JSON Response

struct OMDbResult {
  let Poster: String
}
