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
    let movieCd: String
    let movieNm: String
    let openDt: String
    let audiCnt: String
    
    init(_ boxOfficeResponse: BoxOfficeResponse) {
        self.rank = boxOfficeResponse.rank
        self.rankInten = boxOfficeResponse.rankInten
        self.rankOldAndNew = boxOfficeResponse.rankOldAndNew
        self.movieCd = boxOfficeResponse.movieCd
        self.movieNm = boxOfficeResponse.movieNm
        self.openDt = boxOfficeResponse.openDt
        self.audiCnt = boxOfficeResponse.audiCnt
    }
}

extension BoxOfficeData: Equatable {
    static func == (lhs: BoxOfficeData, rhs: BoxOfficeData) -> Bool {
        return lhs.rank == rhs.rank &&
        lhs.movieCd == rhs.movieCd &&
        lhs.audiCnt == rhs.audiCnt
    }
}
