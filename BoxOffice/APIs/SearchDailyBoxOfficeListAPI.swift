//
//  SearchDailyBoxOfficeListAPI.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/02.
//

import Foundation

struct SearchDailyBoxOfficeListAPI: API {
    typealias ResponseType = DailyBoxOfficeListResponseDTO
    
    var configuration: APIConfiguration
    
    init(date: String, itemPerPage: String = "10") {
        self.configuration = APIConfiguration(
            baseUrl: .kobis,
            param: ["key": Bundle.main.kobisApiKey,
                    "targetDt": date,
                    "wideAreaCd": "0105001",
                    "itemPerPage": itemPerPage],
            path: .dailyBoxOffice
        )
    }
}

struct DailyBoxOfficeListResponseDTO: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

struct BoxOfficeResult: Decodable {
    let boxofficeType: String
    let showRange: String
    let yearWeekTime: String?
    let dailyBoxOfficeList: [BoxOffice]?
    let weeklyBoxOfficeList: [BoxOffice]?
}

struct BoxOffice: Decodable {
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
    let movieNm: String
    let salesAmt: String
    let salesShare: String
    let salesInten: String
    let salesChange: String
    let salesAcc: String
    let audiCnt: String
    let audiInten: String
    let audiChange: String
    let audiAcc: String
    let scrnCnt: String
    let showCnt: String
}
