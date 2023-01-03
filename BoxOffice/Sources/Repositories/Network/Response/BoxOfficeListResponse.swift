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

extension DailyBoxOfficeListResponse {
    
    func toMovies() -> [Movie] {
        return boxOfficeResult.dailyBoxOfficeList.map { $0.toMovie() }
    }
    
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

extension WeeklyBoxOfficeListResponse {
    
    func toMovies() -> [Movie] {
        return boxOfficeResult.weeklyBoxOfficeList.map { $0.toMovie() }
    }
    
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


extension BoxOfficeList {
    
    func toMovie() -> Movie {
        return Movie(
            code: movieCd,
            name: movieNm,
            openDate: openDt.asDate() ?? Date(),
            boxOfficeInfo: BoxOfficeInfo(
                rank: Int(rank) ?? 0,
                rankInten: Int(rankInten) ?? 0,
                rankOldAndNew: rankOldAndNew,
                audienceAccumulation: Int(audiAcc) ?? 0
            )
        )
    }
    
}
