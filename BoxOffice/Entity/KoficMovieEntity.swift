//
//  MovieEntity.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import Foundation

// TODO: Movie json
struct KoficMovieEntity: Codable {
    let boxOfficeResult: BoxOfficeResult
}

// MARK: - BoxOfficeResult
struct BoxOfficeResult: Codable {
    let boxofficeType, showRange: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}

// MARK: - DailyBoxOfficeList
struct DailyBoxOfficeList: Codable {
    let rnum, rank, rankInten: String
    let rankOldAndNew: RankOldAndNew
    let movieCd, movieNm, openDt, salesAmt: String
    let salesShare, salesInten, salesChange, salesAcc: String
    let audiCnt, audiInten, audiChange, audiAcc: String
    let scrnCnt, showCnt: String

    enum CodingKeys: String, CodingKey {
        case rnum, rank, rankInten, rankOldAndNew, movieCd
        case movieNm, openDt, salesAmt, salesShare, salesInten, salesChange, salesAcc, audiCnt, audiInten, audiChange, audiAcc, scrnCnt, showCnt
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.rnum = try container.decode(String.self, forKey: .rnum)
        self.rank = try container.decode(String.self, forKey: .rank)
        self.rankInten = try container.decode(String.self, forKey: .rankInten)
        self.rankOldAndNew = try container.decode(RankOldAndNew.self, forKey: .rankOldAndNew)
        self.movieCd = try container.decode(String.self, forKey: .movieCd)
        self.movieNm = try container.decode(String.self, forKey: .movieNm)
        self.openDt = try container.decode(String.self, forKey: .openDt)
        self.salesAmt = try container.decode(String.self, forKey: .salesAmt)
        self.salesShare = try container.decode(String.self, forKey: .salesShare)
        self.salesInten = try container.decode(String.self, forKey: .salesInten)
        self.salesChange = try container.decode(String.self, forKey: .salesChange)
        self.salesAcc = try container.decode(String.self, forKey: .salesAcc)
        self.audiCnt = try container.decode(String.self, forKey: .audiCnt)
        self.audiInten = try container.decode(String.self, forKey: .audiInten)
        self.audiChange = try container.decode(String.self, forKey: .audiChange)
        self.audiAcc = try container.decode(String.self, forKey: .audiAcc)
        self.scrnCnt = try container.decode(String.self, forKey: .scrnCnt)
        self.showCnt = try container.decode(String.self, forKey: .showCnt)
    }
}

enum RankOldAndNew: String, Codable {
    case old = "OLD"
    case new = "NEW"
}

/*****************************************************************************/

// MARK: - KopicMovieDetail
struct KopicMovieDetail: Codable {
    let movieInfoResult: MovieInfoResult
}

// MARK: - MovieInfoResult
struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
    let source: String
}

// MARK: - MovieInfo
struct MovieInfo: Codable {
    let movieCD, movieNm, movieNmEn, movieNmOg: String
    let showTm, prdtYear, openDt, prdtStatNm: String
    let typeNm: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]

    enum CodingKeys: String, CodingKey {
        case movieCD
        case movieNm, movieNmEn, movieNmOg, showTm, prdtYear, openDt, prdtStatNm, typeNm, nations, genres, directors, actors, showTypes, companys, audits, staffs
    }
}

// MARK: - Actor
struct Actor: Codable {
    let peopleNm, peopleNmEn, cast, castEn: String
}

// MARK: - Audit
struct Audit: Codable {
    let auditNo, watchGradeNm: String
}

// MARK: - Company
struct Company: Codable {
    let companyCD, companyNm, companyNmEn, companyPartNm: String

    enum CodingKeys: String, CodingKey {
        case companyCD
        case companyNm, companyNmEn, companyPartNm
    }
}

// MARK: - Director
struct Director: Codable {
    let peopleNm, peopleNmEn: String
}

// MARK: - Genre
struct Genre: Codable {
    let genreNm: String
}

// MARK: - Nation
struct Nation: Codable {
    let nationNm: String
}

// MARK: - ShowType
struct ShowType: Codable {
    let showTypeGroupNm, showTypeNm: String
}
