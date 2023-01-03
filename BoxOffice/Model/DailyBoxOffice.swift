//
//  DayBoxOffice.swift
//  BoxOffice
//
//  Created by 박도원 on 2023/01/03.
//

import Foundation

struct DailyBoxOffice: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}
