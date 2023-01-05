//
//  DetailBoxOffice.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/03.
//

import Foundation

struct DetailBoxOfficeConnection: Decodable {
    let result: DetailBoxOfficeResult
    
    enum CodingKeys: String, CodingKey {
        case result = "movieInfoResult"
    }
}

struct DetailBoxOfficeResult: Decodable {
    let movieInfo: DetailBoxOffice
    
    enum CodingKeys: String, CodingKey {
        case movieInfo = "movieInfo"
    }
}

struct DetailBoxOffice: Decodable {
    let movieCode: String
    let productionYear: String
    let openDate: String
    let showTime: String
    let genre: [BoxOfficeGenre]
    let directors: [BoxOfficeDirectors]
    let actors: [BoxOfficeActors]?
    let audits: [BoxOfficeAudits]
    let movieName: String
    let movieEnglishName: String
    
    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case productionYear = "prdtYear"
        case openDate = "openDt"
        case showTime = "showTm"
        case genre = "genres"
        case directors = "directors"
        case actors = "actors"
        case audits = "audits"
        case movieName = "movieNm"
        case movieEnglishName = "movieNmEn"
    }
}


struct BoxOfficeGenre: Decodable {
    let genreName: String
    
    enum CodingKeys: String, CodingKey {
        case genreName = "genreNm"
    }
}

struct BoxOfficeDirectors: Decodable {
    let peopleName: String?
    let peopleEnglishName: String
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
        case peopleEnglishName = "peopleNmEn"
    }
}

struct BoxOfficeActors: Decodable {
    let peopleName: String?
    
    enum CodingKeys: String, CodingKey {
        case peopleName = "peopleNm"
    }
}

struct BoxOfficeAudits: Decodable {
    let watchGrade: String
    
    enum CodingKeys: String, CodingKey {
        case watchGrade = "watchGradeNm"
    }
}
