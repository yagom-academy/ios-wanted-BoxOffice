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
}

struct MainBoxOfficeList: Codable {
    let boxofficeType: String
    let showRange: String
    let dailyBoxOfficeList: [MovieInfost]
}

struct BoxOffice: Codable {
    let boxOfficeResult: MainBoxOfficeList
}





struct Empty: Codable {
    let movieInfoResult: MovieInfoResult
}


struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
    let source: String
}


struct MovieInfo: Codable {
    let movieCD, movieNm, movieNmEn, movieNmOg: String   // movieNm 제목
    let showTm, prdtYear, openDt, prdtStatNm: String   //showTm 상영시간, openDt 개봉연도, prdtYear 제작연도
    let typeNm: String
    let nations: [Nation]
    let genres: [Genre]   //장르
    let directors: [Director]  //감독
    let actors: [Actor]  //배우
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]  //관람등급
    let staffs: [Staff]
}


struct Actor: Codable {
    let peopleNm : String    // peopleNm배우명  같다?
}

struct Audit: Codable {
    let watchGradeNm: String   //watchGradeNm 관람등급
}

// MARK: - Company
struct Company: Codable {
    let companyCD, companyNm, companyNmEn, companyPartNm: String
}


struct Director: Codable {
    let peopleNm, peopleNmEn: String   // peopleNm 감독명
}


struct Genre: Codable {
    let genreNm: String  //장르
}


struct Nation: Codable {
    let nationNm: String
}


struct ShowType: Codable {
    let showTypeGroupNm, showTypeNm: String
}


struct Staff: Codable {
    let peopleNm, peopleNmEn, staffRoleNm: String
}
