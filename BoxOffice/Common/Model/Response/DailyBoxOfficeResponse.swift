//
//  DailyBoxOfficeResponse.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/18.
//

import Foundation

struct DailyBoxOfficeResultResponse: Codable {
    let boxOfficeResult: DailyBoxOfficeResponse
}

struct DailyBoxOfficeResponse: Codable {
    let showRange: String
    let dailyBoxOfficeList: [BoxOfficeResponse]
}
