//
//  Model.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/17.
//

import Foundation



struct MovieInfost: Codable {
    let rank: String // 랭킹
    let rankInten: String // 전일대비 순위변동 순위증감
    let rankOldAndNew: String // 신규랭크? 인거같음  랭킹에 신규 진입여부
    let audiAcc: String // 누적관객
    let movieNm: String // 영화제목
    let openDt: String  // 개봉일
    /// 영화코드
    let movieCd: String
}


struct MainBoxOfficeList: Codable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieInfost]
}

struct BoxOffice: Codable {
    let boxOfficeResult: MainBoxOfficeList
}


//1111111111111111
//-------------------------------------------
//2222222222222222
struct testInfo {
    let movieNm: String   // movieNm 제목
    let showTm, prdtYear, openDt: String   //showTm 상영시간, openDt 개봉연도, prdtYear 제작연도
    let genres: [Genre]   //장르
    let directors: [Director]  //감독
    let actors: [Actor]  //배우
    let audits: [Audit]  //관람등급
}

struct Empty: Codable {
    let movieInfoResult: MovieInfoResult
}


struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
    let source: String
}

struct MovieInfo: Codable {
    let movieNm: String   // movieNm 제목
    let showTm, prdtYear, openDt: String   //showTm 상영시간, openDt 개봉연도, prdtYear 제작연도
    let genres: [Genre]   //장르
    let directors: [Director]  //감독
    let actors: [Actor]  //배우
    let audits: [Audit]  //관람등급
}

struct Actor: Codable {  // 57번배우명
    let peopleNm : String    // peopleNm배우명  같다?
}

struct Audit: Codable {  //58번 관람등급
    let watchGradeNm: String   //watchGradeNm 관람등급
}

struct Director: Codable { //56번
    let peopleNm: String   // peopleNm 감독명
}


struct Genre: Codable { //5번
    let genreNm: String  //장르
}


//// MARK: - Empty
//struct Empty: Codable {
//    let movieInfoResult: MovieInfoResult
//}
//
//// MARK: - MovieInfoResult
//struct MovieInfoResult: Codable {
//    let movieInfo: MovieInfo
//    let source: String
//}
//
//
//// MARK: - MovieInfo
//struct MovieInfo: Codable {
//    let movieCD, movieNm, movieNmEn, movieNmOg: String
//    let showTm, prdtYear, openDt, prdtStatNm: String
//    let typeNm: String
//    let nations: [Nation]
//    let genres: [Genre]
//    let directors: [Director]
//    let actors: [Actor]
//    let showTypes: [ShowType]
//    let companys: [Company]
//    let audits: [Audit]
//    let staffs: [Staff]
//
//    enum CodingKeys: String, CodingKey {
//        case movieCD = "movieCd"
//        case movieNm, movieNmEn, movieNmOg, showTm, prdtYear, openDt, prdtStatNm, typeNm, nations, genres, directors, actors, showTypes, companys, audits, staffs
//    }
//}
//
//// MARK: - Actor
//struct Actor: Codable {
//    let peopleNm, peopleNmEn, cast, castEn: String
//}
//
//// MARK: - Audit
//struct Audit: Codable {
//    let auditNo, watchGradeNm: String
//}
//
//// MARK: - Company
//struct Company: Codable {
//    let companyCD, companyNm, companyNmEn, companyPartNm: String
//
//    enum CodingKeys: String, CodingKey {
//        case companyCD = "companyCd"
//        case companyNm, companyNmEn, companyPartNm
//    }
//}
//
//// MARK: - Director
//struct Director: Codable {
//    let peopleNm, peopleNmEn: String
//}
//
//// MARK: - Genre
//struct Genre: Codable {
//    let genreNm: String
//}
//
//// MARK: - Nation
//struct Nation: Codable {
//    let nationNm: String
//}
//
//// MARK: - ShowType
//struct ShowType: Codable {
//    let showTypeGroupNm, showTypeNm: String
//}
//
//// MARK: - Staff
//struct Staff: Codable {
//    let peopleNm, peopleNmEn, staffRoleNm: String
//}
