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
    var openDate: Date
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
            openDate: Date(),
            boxOfficeInfo: BoxOfficeInfo(
                rank: 1,
                rankInten: 1,
                rankOldAndNew: .OLD,
                audienceAccumulation: 40541108500),
            detailInfo: MovieDetailInfo(
                movieNameEnglish: "Mission: Impossible: Ghost Protocol",
                showTime: 132,
                productionYear: "2011",
                genres: ["액션", "드라마"],
                directors: ["브래드 버드"],
                actors: ["톰 크루즈", "제레미 레너"],
                audit: "15세이상관람가",
                poster: "https://m.media-amazon.com/images/M/MV5BMTY4MTUxMjQ5OV5BMl5BanBnXkFtZTcwNTUyMzg5Ng@@._V1_SX300.jpg"))
    }
    
    func prettify() -> String {
        var result = ""
        result += "영화명: \(self.movieName)\n"
        if let rank = self.boxOfficeInfo?.rank {
            result += "박스오피스 순위: \(rank)\n"
        }
        result += "개봉일: \(self.openDate.toString(.yyyyMMddDot))\n"
        if let audienceCount = self.boxOfficeInfo?.audienceAccumulation.formattedString(.audience) {
            result += "관객수: \(audienceCount)명\n"
        }
        if let rankInten = self.boxOfficeInfo?.rankInten {
            result += "전일 대비 증감분: \(rankInten)\n"
        }
        if let rankOldAndNew = self.boxOfficeInfo?.rankOldAndNew {
            result += "순위 신규 진입 여부: \(rankOldAndNew.rawValue)\n"
        }
        if let productionYear = self.detailInfo?.productionYear {
            result += "제작연도: \(productionYear)\n"
        }
        result += "개봉일: \(self.openDate.toString(.yyyyMMddDot))\n"
        if let showTime = self.detailInfo?.showTime.formattedString(.showTime) {
            result += "상영시간: \(showTime)\n"
        }
        if let genres = self.detailInfo?.genres {
            result += "장르: \(genres.reduce("", { $0.isEmpty ? $1 : "\($0)/\($1)" }))\n"
        }
        if let directors = self.detailInfo?.directors {
            result += "감독명: \(directors.reduce("", { $0.isEmpty ? $1 : "\($0), \($1)" }))\n"
        }
        if let actors = self.detailInfo?.actors {
            result += "배우명: \(actors.reduce("", { $0.isEmpty ? $1 : "\($0), \($1)" }))\n"
        }
        if let audit = self.detailInfo?.audit {
            result += "관람등급 명칭: \(audit)\n"
        }
        return result
    }
}
