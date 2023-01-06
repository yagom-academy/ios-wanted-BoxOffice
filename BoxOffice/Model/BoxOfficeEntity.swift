//
//  BoxOfficeEntity.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

struct BoxOfficeEntity: Decodable {
    let boxOfficeResult: BoxOffice
}

struct BoxOffice: Decodable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [DailyBoxoffice]
}

struct DailyBoxoffice: Decodable {
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: RankOldOrNew
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

enum RankOldOrNew: String, Decodable {
    case old = "OLD"
    case new = "NEW"
    
    var value: String {
        switch self {
        case .old:
            return "OLD"
        case .new:
            return "NEW"
        }
    }
}
