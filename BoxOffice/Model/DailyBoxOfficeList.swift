//
//  DailyBoxOfficeList.swift
//  BoxOffice
//
//  Created by 박도원 on 2023/01/03.
//

import Foundation

struct DailyBoxOfficeList: Decodable, Hashable {
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
    let movieNm: String
    let openDt: String
    let audiAcc: String
}
