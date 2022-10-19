//
//  BoxOffice.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/18.
//

import Foundation

struct Movie {
    var movieCode: String
    var movieName: String
    var openDate: String
    var boxOfficeInfo: BoxOfficeInfo?
    var detailInfo: MovieDetailInfo?
}

struct BoxOfficeInfo {
    var rank: Int
    var rankInten: Int
    var rankOldAndNew: RankType
    var audienceCount: Int
    var audienceInten: Int
    var audienceChange: Int
    var audienceAccumulation: Int
    
    enum RankType: String, Codable {
        case OLD
        case NEW
    }
}

struct MovieDetailInfo {
    var movieNameEnglish: String
    var showTime: Int
    var productionYear: String
    var genres: [String]
    var directors: [String]
    var actors: [String]
    var audit: String
    var poster: String?
}
