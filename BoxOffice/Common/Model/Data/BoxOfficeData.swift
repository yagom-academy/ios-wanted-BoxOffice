//
//  BoxOfficeData.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/18.
//

import Foundation

struct BoxOfficeData {
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieNm: String
    let openDt: String
    let audiCnt: String
    
    init(boxOfficeResponse: BoxOfficeResponse) {
        self.rank = boxOfficeResponse.rank
        self.rankInten = boxOfficeResponse.rankInten
        self.rankOldAndNew = boxOfficeResponse.rankOldAndNew
        self.movieNm = boxOfficeResponse.movieNm
        self.openDt = boxOfficeResponse.openDt
        self.audiCnt = boxOfficeResponse.audiCnt
    }
}
