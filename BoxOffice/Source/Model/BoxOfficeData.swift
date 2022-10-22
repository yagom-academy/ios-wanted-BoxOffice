//
//  MovieData.swift
//  BoxOffice
//
//  Created by KangMingyo on 2022/10/18.
//

import Foundation

struct BoxOfficeData : Codable {
    let boxOfficeResult : BoxOfficeResult
}

struct BoxOfficeResult : Codable {
    let dailyBoxOfficeList : [DailyBoxOfficeList]
}

struct DailyBoxOfficeList : Codable {
    let rank: String
    let rankInten: String
    let movieNm: String
    let openDt: String
    let audiAcc: String
    let rankOldAndNew: String
    let movieCd: String
}
