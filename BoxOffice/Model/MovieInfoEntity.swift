//
//  MovieInfoEntity.swift
//  BoxOffice
//
//  Created by 이은찬 on 2023/01/03.
//

import Foundation

struct MovieInfoEntity: Decodable {
    let movieInfoResult: MovieInfoResult
}

struct MovieInfoResult: Decodable {
    let movieInfo: MovieInfo
    let source: String
}

struct MovieInfo: Decodable {
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
    let staffs: [Staff]

    enum CodingKeys: String, CodingKey {
        case movieCD = "movieCd"
        case movieNm, movieNmEn, movieNmOg, showTm, prdtYear, openDt, prdtStatNm, typeNm, nations, genres, directors, actors, showTypes, companys, audits, staffs
    }
}

struct Actor: Decodable {
    let peopleNm, peopleNmEn, cast, castEn: String
}

struct Audit: Decodable {
    let auditNo, watchGradeNm: String
}

struct Company: Decodable {
    let companyCD, companyNm, companyNmEn, companyPartNm: String

    enum CodingKeys: String, CodingKey {
        case companyCD = "companyCd"
        case companyNm, companyNmEn, companyPartNm
    }
}

struct Director: Decodable {
    let peopleNm, peopleNmEn: String
}

struct Genre: Decodable {
    let genreNm: String
}

struct Nation: Decodable {
    let nationNm: String
}

struct ShowType: Decodable {
    let showTypeGroupNm, showTypeNm: String
}

struct Staff: Decodable {
    let peopleNm, peopleNmEn, staffRoleNm: String
}
