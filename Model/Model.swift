//
//  Model.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/17.
//

import Foundation


struct Movie {
    let ranking: Int
    let movie: String?
    let movieTitle: String?
    let audience: Int
    let openingDate: Int
    let newRanking: Int
    let comparedToYesterday: Int
}



struct DailyBoxOfficeList: Codable {
    let rank: String // 랭킹
    let rankInten: String // 전일대비 순위변동??
    let rankOldAndNew: String // 신규랭크? 인거같음
    let movieCd: String // 개봉일자
    let movieNm: String? // 영화제목
    let openDt: String  // 개봉일
}

struct MainBoxOfficeList: Codable {
    let boxOfficeList: [DailyBoxOfficeList]
}
