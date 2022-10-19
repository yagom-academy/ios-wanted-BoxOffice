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
