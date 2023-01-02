//
//  SearchMovieInfoAPI.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/02.
//

import Foundation

struct SearchMovieInfoAPI: API {
    typealias ResponseType = MovieInfoResponseDTO
    
    var configuration: APIConfiguration
    
    init(movieCode: String) {
        self.configuration = APIConfiguration(
            baseUrl: .kobis,
            param: ["key": Bundle.main.kobisApiKey,
                    "movieCd": movieCode],
            path: .movieInfo
        )
    }
}

struct MovieInfoResponseDTO: Decodable {
    let movieInfoResult: MovieInfoResult
}
struct MovieInfoResult: Decodable {
    let movieInfo: MovieInfo
    // let source: String
}
struct MovieInfo: Decodable {
    let movieCd: String
    let movieNm: String
    let movieNmEn: String
    let movieNmOg: String
    let showTm: String
    let prdYear: String
    let openDt: String
    let prdStatNm: String
    let typeNm: String
    let nations: [Nation]
    let genres: [Genre]
    let directors: [Director]
    let actors: [Actor]
    let showTypes: [ShowType]
    let companys: [Company]
    let audits: [Audit]
    let staffs: [Staff]
}

struct Nation: Decodable {
    let nationNm: String
}
struct Genre: Decodable {
    let genreNm: String
}
struct Director: Decodable {
    let peopleNm: String
    let peopleNmEn: String
}
struct Actor: Decodable {
    let peopleNm: String
    let peopleNmEn: String
    let cast: String
    let caseEn: String
}
struct ShowType: Decodable {
    let showTypeGroupNm: String
    let showTypeNm: String
}
struct Company: Decodable {
    let companyCd: String
    let companyNm: String
    let companyNmEn: String
    let companyPartNm: String
}
struct Audit: Decodable {
    let auditNo: String
    let watchGradeNm: String
}
struct Staff: Decodable {
    let peopleNm: String
    let peopleNmEn: String
    let staffRoleNm: String
}

