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


extension Movie {
    static var dummyMovie: Movie {
        return Movie(
            movieCode: "20112207",
            movieName: "미션임파서블:고스트프로토콜",
            openDate: "2011-12-15",
            boxOfficeInfo: BoxOfficeInfo(
                rank: 1,
                rankInten: 1,
                rankOldAndNew: .OLD,
                audienceAccumulation: 40541108500),
            detailInfo: MovieDetailInfo(
                movieNameEnglish: "Mission: Impossible: Ghost Protocol",
                showTime: 132,
                productionYear: "2011",
                genres: ["액션"],
                directors: ["브래드 버드"],
                actors: ["톰 크루즈", "제레미 레너"],
                audit: "15세이상관람가",
                poster: "https://m.media-amazon.com/images/M/MV5BMTY4MTUxMjQ5OV5BMl5BanBnXkFtZTcwNTUyMzg5Ng@@._V1_SX300.jpg"))
    }
}
