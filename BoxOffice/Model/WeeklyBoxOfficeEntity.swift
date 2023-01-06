//
//  WeeklyBoxOfficeEntity.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/06.
//

import Foundation

struct WeeklyBoxOfficeEntity: Decodable {
    let boxOfficeResult: BoxOfficeResult
    
    struct BoxOfficeResult: Decodable {
        let weeklyBoxOfficeList: [WeeklyBoxOfficeList]
        
        struct WeeklyBoxOfficeList: Decodable {
            let rank: String
            let movieNm: String
            let openDt: String
            let audiAcc: String
            let rankInten: String
            let rankOldAndNew: String
        }
    }
}
