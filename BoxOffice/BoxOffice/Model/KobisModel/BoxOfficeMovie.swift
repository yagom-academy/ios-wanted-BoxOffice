//
//  BoxOfficeMovie.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

import Foundation

struct BoxOfficeMovie: Decodable, Hashable {
    let rank: String // 박스오피스 순위
    let movieName: String // 영화명
    let openDate: String // 개봉일
    let audienceAttendance: String // 관객수
    let rankIncrease: String // 전일대비 순위의 증감분
    let isNewRanked: String // 랭킹에 신규 진입 여부
    let movieCode: String // 무비 코드
    
    private enum CodingKeys: String, CodingKey {
        case rank
        case movieName = "movieNm"
        case openDate = "openDt"
        case audienceAttendance = "audiAcc"
        case rankIncrease = "rankInten"
        case isNewRanked = "rankOldAndNew"
        case movieCode = "movieCd"
    }
}
