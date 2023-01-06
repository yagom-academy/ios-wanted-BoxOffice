//
//  BoxOfficeEntity.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

struct DailyBoxOfficeEntity: Decodable {
    let boxOfficeResult: BoxOfficeResult
    
    struct BoxOfficeResult: Decodable {
        let dailyBoxOfficeList: [DailyBoxOfficeList]
        
        struct DailyBoxOfficeList: Decodable {
            let movieCd: String
            let rank: String
            let movieNm: String
            let openDt: String
            let audiAcc: String
            let rankInten: String
            let rankOldAndNew: String
        }
    }
}
