//
//  BoxOfficeModel.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/18.
//

import Foundation

// MARK: - BoxOffice
struct BoxOfficeModel: Decodable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Decodable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
    
    enum CodingKeys: String, CodingKey {
        case boxofficeType, showRange, dailyBoxOfficeList, weeklyBoxOfficeList
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        boxofficeType = try container.decode(String.self, forKey: .boxofficeType)
        showRange = try container.decode(String.self, forKey: .showRange)
        if let id = try container.decodeIfPresent([DailyBoxOfficeList].self, forKey: .weeklyBoxOfficeList) {
            dailyBoxOfficeList = id
        } else {
            dailyBoxOfficeList = try container.decode([DailyBoxOfficeList].self, forKey: .dailyBoxOfficeList)
        }
    }
    
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
    case new = "NEW"
    case old = "OLD"
}

