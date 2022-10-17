//
//  movieModel.swift
//  BoxOffice
//
//  Created by so on 2022/10/17.
//

import Foundation

struct movieCodable: Codable {
    

    struct DailyBoxOfficeList : Codable {
        let rank : String
        let rankInten: String
        let movieNm : String
        let openDt : String
    }
    let dailyBoxOfficeList : DailyBoxOfficeList
}
