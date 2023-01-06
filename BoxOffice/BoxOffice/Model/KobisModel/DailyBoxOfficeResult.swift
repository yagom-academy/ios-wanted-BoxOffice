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
    let boxOfficeType: String
    let showRange: String
    let dailyBoxOfficeList: [BoxOfficeMovie]
    
    private enum CodingKeys: String, CodingKey {
        case boxOfficeType = "boxofficeType"
        case showRange
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
