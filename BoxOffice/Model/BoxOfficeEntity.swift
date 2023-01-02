//
//  BoxOfficeEntity.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

struct BoxOfficeEntity: Decodable {
    let boxofficeType: String
    let showRange: String
    let rnum: String
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
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
