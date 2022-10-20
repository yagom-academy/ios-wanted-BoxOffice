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
        self.rnum = try container.decode(String.self, forKey: .rnum) //순번을 출력
        self.rank = try container.decode(String.self, forKey: .rank) //해당일자의 박스오피스 순위를 출력
        self.rankInten = try container.decode(String.self, forKey: .rankInten) //전일 대비 순위의 증감분
        self.rankOldAndNew = try container.decode(RankOldAndNew.self, forKey: .rankOldAndNew) //랭킹에 신규진입여부를 출력 OLD: 기존, NEW: 신규
        self.movieCd = try container.decode(String.self, forKey: .movieCd) //영화의 대표코드
        self.movieNm = try container.decode(String.self, forKey: .movieNm) //영화명 국문
        self.openDt = try container.decode(String.self, forKey: .openDt) //영화 개봉일
        self.salesAmt = try container.decode(String.self, forKey: .salesAmt) //해당일의 매출액
        self.salesShare = try container.decode(String.self, forKey: .salesShare) //해당일자 상영작의 매출총액 대비 해당 영화의 매출비율
        self.salesInten = try container.decode(String.self, forKey: .salesInten) //전일 대비 매출액 증감분
        self.salesChange = try container.decode(String.self, forKey: .salesChange) //전일 대비 매출액 증감 비율
        self.salesAcc = try container.decode(String.self, forKey: .salesAcc) //누적매출액
        self.audiCnt = try container.decode(String.self, forKey: .audiCnt) //해당일의 관객수
        self.audiInten = try container.decode(String.self, forKey: .audiInten) //전일 대비 관객수 증감분
        self.audiChange = try container.decode(String.self, forKey: .audiChange) //전일 대비 관객수 증감 비율
        self.audiAcc = try container.decode(String.self, forKey: .audiAcc) //누적관객수
        self.scrnCnt = try container.decode(String.self, forKey: .scrnCnt) //해당일자에 상영한 스크린 수
        self.showCnt = try container.decode(String.self, forKey: .showCnt) //해당일자에 상영된 횟수
    }
}

enum RankOldAndNew: String, Codable {
    case old = "OLD"
    case new = "NEW"
}

/*****************************************************************************/

// MARK: - KopicMovieDetail
struct KoficMovieDetailEntity: Codable {
    let movieInfoResult: MovieInfoResult
}

// MARK: - MovieInfoResult
struct MovieInfoResult: Codable {
    let movieInfo: MovieInfo
    let source: String
}

// MARK: - MovieInfo
struct MovieInfo: Codable {
    let movieCd, movieNm, movieNmEn, movieNmOg: String
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
        case movieCd
        case movieNm, movieNmEn, movieNmOg, showTm, prdtYear, openDt, prdtStatNm, typeNm, nations, genres, directors, actors, showTypes, companys, audits
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.movieCd = try container.decode(String.self, forKey: .movieCd) //영화코드
        self.movieNm = try container.decode(String.self, forKey: .movieNm) //영화명 국문
        self.movieNmEn = try container.decode(String.self, forKey: .movieNmEn) //영화명 영문
        self.movieNmOg = try container.decode(String.self, forKey: .movieNmOg) //영화명 원문
        self.showTm = try container.decode(String.self, forKey: .showTm) //상영시간
        self.prdtYear = (try? container.decode(String.self, forKey: .prdtYear)) ?? "" //제작연도
        self.openDt = try container.decode(String.self, forKey: .openDt) //개봉연도
        self.prdtStatNm = try container.decode(String.self, forKey: .prdtStatNm) //제작상태명
        self.typeNm = try container.decode(String.self, forKey: .typeNm) //영화유형명
        self.nations = try container.decode([Nation].self, forKey: .nations) //제작국가
        self.genres = try container.decode([Genre].self, forKey: .genres) //api 명세에 없음
        self.directors = try container.decode([Director].self, forKey: .directors) //감독
        self.actors = try container.decode([Actor].self, forKey: .actors) //배우
        self.showTypes = try container.decode([ShowType].self, forKey: .showTypes) //상영형태 구분
        self.companys = try container.decode([Company].self, forKey: .companys) //참여 영화사
        self.audits = try container.decode([Audit].self, forKey: .audits) //심의정보
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
    let companyCd, companyNm, companyNmEn, companyPartNm: String

    enum CodingKeys: String, CodingKey {
        case companyCd
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
