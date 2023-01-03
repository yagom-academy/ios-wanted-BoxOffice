//
//  Movie.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation

struct Movie {
    
    let code: String
    let name: String
    let openDate: Date
    var boxOfficeInfo: BoxOfficeInfo?
    var detailInfo: MovieDetailInfo?
    
}

struct BoxOfficeInfo {
    
    let rank: Int
    let rankInten: Int
    let rankOldAndNew: RankOldAndNew
    let audienceAccumulation: Int
    
}

struct MovieDetailInfo {
    
    let movieNameEnglish: String
    let showTime: Int
    let productionYear: String
    let genres: [String]
    let directors: [String]
    let actors: [String]
    let audit: String
    var poster: String?
    
}
