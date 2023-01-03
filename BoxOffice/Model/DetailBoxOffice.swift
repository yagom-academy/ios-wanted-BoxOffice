//
//  DetailBoxOffice.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/03.
//

import Foundation

struct DetailBoxOffice: Decodable {
    let movieCode: String
    let productionYear: String
    let openDate: String
    let showTime: String
    let genreName: String
    let dirctors: String
    let actors: String
    let watchGradeName: String
    let movieEnglishName: String
    
    enum CodingKeys: String, CodingKey {
        case movieCode = "MovieCd"
        case productionYear = "prdtYear"
        case openDate = "openDt"
        case showTime = "showTm"
        case genreName = "genreNm"
        case dirctors = "directors"
        case actors = "actors"
        case watchGradeName = "watchGradeNm"
        case movieEnglishName = "movieNmEn"
    }
}
