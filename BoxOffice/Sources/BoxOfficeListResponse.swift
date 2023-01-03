//
//  BoxOfficeListResponse.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation

// MARK: - DailyBoxOfficeListResponse
struct DailyBoxOfficeListResponse: Codable {
    
    let boxOfficeResult: DailyBoxOfficeResult
    
}

struct DailyBoxOfficeResult: Codable {
    
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [BoxOfficeList]
    
}

// MARK: - WeeklyBoxOfficeListResponse
struct WeeklyBoxOfficeListResponse: Codable {
    
    let boxOfficeResult: WeeklyBoxOfficeResult
    
}

struct WeeklyBoxOfficeResult: Codable {
    
    let boxofficeType: String
    let showRange: String?
    let yearWeekTime: String
    let weeklyBoxOfficeList: [BoxOfficeList]
    
}

// MARK: - BoxOfficeList
struct BoxOfficeList: Codable {
    
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: RankOldAndNew
    let movieCd: String
    let movieNm: String
    let openDt: String
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

enum RankOldAndNew: String, Codable {
    
    case new = "NEW"
    case old = "OLD"
    
}
