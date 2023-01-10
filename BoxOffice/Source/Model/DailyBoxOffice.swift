//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by dhoney96 on 2023/01/02.
//

import Foundation

// MARK: 일일 박스오피스 DTO
struct BoxOfficeResult: Decodable {
    let boxOfficeResult: DailyBoxOffice
}

struct DailyBoxOffice: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [BoxOfficeInfo]
}

struct BoxOfficeInfo: Decodable {
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieNm: String
    let openDt: String
    let audiAcc: String
    let movieCd: String
}
