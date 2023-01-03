//
//  BoxOfficeResult.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

import Foundation

struct DailyBoxOfficeResponse: Decodable {
    let boxOfficeResult: DailyBoxOfficeResult
}

struct DailyBoxOfficeResult: Decodable {
//    let boxOfficeType: String
//    let showRange: String
//    데이터가 필요없는 것들은 모델에서 지워줄까?
    let dailyBoxOfficeList: [BoxOfficeMovie]
    
    private enum CodingKeys: String, CodingKey {
//        case boxOfficeType = "boxofficeType"
//        case showRange
        case dailyBoxOfficeList
    }
}

struct WeeklyBoxOfficeResponse: Decodable {
    let boxOfficeResult: WeeklyBoxOfficeResult
}

struct WeeklyBoxOfficeResult: Decodable {
    let boxOfficeType: String
    let showRange: String
    let weeklyBoxOfficeList: [BoxOfficeMovie]
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
        case weeklyBoxOfficeList
    }
}
