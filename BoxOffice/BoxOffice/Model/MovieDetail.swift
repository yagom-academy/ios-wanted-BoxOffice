//
//  MovieDetail.swift
//  BoxOffice
//
//  Created by bard on 2023/01/03.
//

import Foundation

struct MovieDetailResponse: Decodable {
    let movieDetailResult: MovieDetailResult
    
    private enum CodingKeys: String, CodingKey {
        case movieDetailResult = "movieInfoResult"
    }
}

struct MovieDetailResult: Decodable {
    let movieDetail: MovieDetail
    
    private enum CodingKeys: String, CodingKey {
        case movieDetail = "movieInfo"
    }
}

struct MovieDetail: Decodable {
//    let rank: String
//    let movieName: String
//    let openDate: String
//    let audienceAttendance: String
//    let rankIncrease: String
//    let isNewRanked: String
    // --- for detail ---
    let productionYear: String
    let showTime: String
    let typeNumber: String
    let directors: [Director]
    let actors: [Actor]
    let genres: [Genre]
    let audits: [Audit]
    
    private enum CodingKeys: String, CodingKey {
//        case rank
//        case movieName = "movieNm"
//        case openDate = "openDt"
//        case audienceAttendance = "audiAcc"
//        case rankIncrease = "rankInten"
//        case isNewRanked = "rankOldAndNew"
        
        case productionYear = "prdtYear"
        case showTime = "showTm"
        case typeNumber = "typeNm"
        case directors
        case actors
        case genres
        case audits
    }
}

struct Director: Decodable, Hashable {
    let peopleName: String
    let peopleEnglishName: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
    }
}

struct Actor: Decodable, Hashable {
    let peopleName: String
    let peopleEnglishName: String
    let cast: String
    let castEnglishName: String
    
    private enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
        case cast
        case castEnglishName = "castEn"
    }
}

struct Genre: Decodable, Hashable {
    let genreName: String
    
    private enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

struct Audit: Decodable, Hashable {
    let auditNumber: String
    let watchGradeName: String
    
    private enum CodingKeys: String, CodingKey {
        case auditNumber = "auditNo"
        case watchGradeName = "watchGradeNm"
    }
}
