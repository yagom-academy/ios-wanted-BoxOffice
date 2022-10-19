//
//  BoxOfficeModel.swift
//  BoxOffice
//
//  Created by 유영훈 on 2022/10/17.
//

/*
 박스오피스 순위
 영화명
 개봉일
 관객수
 전일대비 순위의 증감분
 랭킹에 신규 진입 여부
 */

struct BoxOfficeModel: Codable {
    var rnum: String
    var rank: String
    var rankInten: String
    var rankOldAndNew: String
    var movieCd: String
    var movieNm: String
    var openDt: String
    var audiCnt: String
//    var salesAmt: String
//    var salesShare: String
//    var salesInten: String
//    var salesChange: String
//    var salesAcc: String
//    var audiInten: String
//    var audiChange: String
//    var audiAcc: String
//    var scrnCnt: String
//    var showCnt: String
    
    enum CodingKeys: String, CodingKey {
        case rnum
        case rank
        case rankInten
        case rankOldAndNew
        case movieCd
        case movieNm
        case openDt
        case audiCnt
//        case salesAmt
//        case salesShare
//        case salesInten
//        case salesChange
//        case salesAcc
//        case audiInten
//        case audiChange
//        case audiAcc
//        case scrnCnt
//        case showCnt
    }
}

struct BoxOfficeResultRoot: Codable {
    var boxOfficeResult : BoxOfficeResult
}

struct BoxOfficeResult: Codable {
    var boxofficeType: String
    var showRange: String
    var dailyBoxOfficeList: [BoxOfficeModel]
    
    enum CodingKeys: String, CodingKey {
        case boxofficeType
        case showRange
        case dailyBoxOfficeList = "dailyBoxOfficeList"
    }
}
