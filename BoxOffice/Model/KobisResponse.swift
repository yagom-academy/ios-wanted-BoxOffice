//
//  KobisResponse.swift
//  BoxOffice
//
//  Created by sole on 2022/10/21.
//

import Foundation

struct KobisBoxOfficeResponse: Decodable {
    let results: KobisBoxOfficeResult
    
    enum CodingKeys: String, CodingKey {
        case results = "boxOfficeResult"
    }
}

struct KobisBoxOfficeResult: Decodable {
    let dailyBoxOfficeList: [KobisDailyBoxOfficeList]
}

struct KobisDailyBoxOfficeList: Decodable {
    let rank: String
    let ratioComparedToYesterday: String
    let isNewInRank: IsNewInRank
    let movieCode: String
    let movieName: String
    let releasedDate: String
    let dailyAudience: String
    let totlaAudience: String

    enum CodingKeys: String, CodingKey {
        case rank
        case ratioComparedToYesterday = "rankInten"
        case isNewInRank = "rankOldAndNew"
        case movieCode = "movieCd"
        case movieName = "movieNm"
        case releasedDate = "openDt"
        case dailyAudience = "audiCnt"
        case totlaAudience = "audiAcc"
    }
}

struct KobisMovieInfoResponse: Decodable {
    let results: KobisInfoResult
    
    enum CodingKeys: String, CodingKey {
        case results = "movieInfoResult"
    }
}

struct KobisInfoResult: Decodable {
    let movieInfo: KobisMovieInfo
}

struct KobisMovieInfo: Decodable {
    let movieCode: String
    let nameInEnglish: String
    let runningTime: String
    let produnctionYear: String
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let audits: [Audit]

    enum CodingKeys: String, CodingKey {
        case genres, directors, actors, audits
        case movieCode = "movieCd"
        case nameInEnglish = "movieNmEn"
        case runningTime = "showTm"
        case produnctionYear = "prdtYear"
    }
}

struct Actor: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
    }
}

struct Audit: Decodable {
    let watchGrade: String
    
    enum CodingKeys: String, CodingKey {
        case watchGrade = "watchGradeNm"
    }
}

struct Director: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "peopleNm"
    }
}

struct Genre: Decodable {
    let name: String
    
    enum CodingKeys: String, CodingKey {
        case name = "genreNm"
    }
}

