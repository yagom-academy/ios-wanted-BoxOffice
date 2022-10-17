//
//  WeeklyBoxOfficeResponse.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/18.
//

import Foundation

struct WeeklyBoxOfficeResultResponse: Codable {
    let boxOfficeResult: WeeklyBoxOfficeResponse
}

struct WeeklyBoxOfficeResponse: Codable {
    let showRange: String
    let weeklyBoxOfficeList: [BoxOfficeResponse]
}
