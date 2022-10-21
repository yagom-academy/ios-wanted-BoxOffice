//
//  WeekendBoxOfficeDTO.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/21.
//

import Foundation

struct WeekendBoxOfficeDTO: Decodable {
    let boxOfficeResult: WeekBoxOfficeResult
}

struct WeekBoxOfficeResult: Decodable {
    let boxofficeType, showRange, yearWeekTime: String
    let weeklyBoxOfficeList: [WeeklyBoxOfficeList]
}

struct WeeklyBoxOfficeList: Decodable {
    let rnum, rank, rankInten: String
    let rankOldAndNew: RankOldAndNew
    let movieCD, movieNm, openDt, salesAmt: String
    let salesShare, salesInten, salesChange, salesAcc: String
    let audiCnt, audiInten, audiChange, audiAcc: String
    let scrnCnt, showCnt: String

    enum CodingKeys: String, CodingKey {
        case rnum, rank, rankInten, rankOldAndNew
        case movieCD = "movieCd"
        case movieNm, openDt, salesAmt, salesShare, salesInten, salesChange, salesAcc, audiCnt, audiInten, audiChange, audiAcc, scrnCnt, showCnt
    }
}

