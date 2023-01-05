//
//  DailyBoxOffice.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/03.
//

import Foundation

struct CustomBoxOffice: Hashable {
    let boxOffice: DailyBoxOffice
    let posterURL: String
}

struct DailyBoxOfficeConnection: Decodable {
    let boxOfficeResult: BoxOfficeResult
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeResult = "boxOfficeResult"
    }
}

struct BoxOfficeResult: Decodable {
    let boxOfficeList: [DailyBoxOffice]
    
    enum CodingKeys: String, CodingKey {
        case boxOfficeList = "dailyBoxOfficeList"
    }
}

struct DailyBoxOffice: Decodable, Hashable {
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
