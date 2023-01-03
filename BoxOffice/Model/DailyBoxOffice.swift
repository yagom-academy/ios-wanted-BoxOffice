//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/03.
//

import Foundation

struct DailyBoxOffice: Decodable {
    let movieCode: String
    let rank: String
    let title: String
    let openDate: String
    let audienceCount: String
    let rankInTen: String
    let isNewRank: String
    
    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case rank = "rank"
        case title = "movieNm"
        case openDate = "openDt"
        case audienceCount = "audiCnt"
        case rankInTen = "rankInten"
        case isNewRank = "rankOldAndNew"
    }
}
