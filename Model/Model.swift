//
//  Model.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/17.
//

import Foundation


struct MovieInfo: Codable {
    let rank: String // 랭킹
    let rankInten: String // 전일대비 순위변동 순위증감
    let rankOldAndNew: String // 신규랭크? 인거같음  랭킹에 신규 진입여부
    let audiAcc: String // 누적관객
    let movieNm: String // 영화제목
    let openDt: String  // 개봉일
}

struct MainBoxOfficeList: Codable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieInfo]
}

struct BoxOffice: Codable {
    let boxOfficeResult: MainBoxOfficeList
}
