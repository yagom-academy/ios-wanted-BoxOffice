//
//  MovieOverviewDTO.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/03.
//

import Foundation

struct MovieOverviewDTO: Decodable {
    let movieCode: String
    let rank: UInt
    let title: String
    let openingDay: String
    let audienceNumber: UInt
    let rankFluctuation: Int
    let isNewlyRanked: Bool

    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case rank
        case title = "movieNm"
        case openingDay = "openDt"
        case audienceNumber = "audiAcc"
        case rankFluctuation = "rankInten"
        case isNewlyRanked = "rankOldAndNew"
    }
}
