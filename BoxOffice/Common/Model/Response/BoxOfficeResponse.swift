//
//  BoxOfficeResponse.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/18.
//

import Foundation

struct BoxOfficeResponse: Codable {
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieNm: String
    let openDt: String
    let audiCnt: String
}
