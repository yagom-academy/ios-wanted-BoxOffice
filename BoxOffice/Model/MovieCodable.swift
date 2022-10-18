//
//  movieModel.swift
//  BoxOffice
//
//  Created by so on 2022/10/17.
//

import Foundation

//struct MovieCodable: Codable {
    
//    let boxOfficeResult : BoxOfficeResult
//}
//struct BoxOfficeResult : Codable {
//    let boxofficeType: String
//    let dailyBoxOfficeList : [DailyBoxOfficeList]
//}
//struct DailyBoxOfficeList : Codable {
//    let rank : String
//    let rankInten: String
//    let movieNm : String
//    let openDt : String
//    let rankOldAndNew : String
//    let audiInten : String
//    let audiAcc : String
//}

// MARK: - MovieCodable
struct MovieCodable: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
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

enum RankOldAndNew: String, Codable {
    case old = "OLD"
    case new = "NEW"
}
