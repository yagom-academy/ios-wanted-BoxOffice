//
//  MovieDetailDTO.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/03.
//

import Foundation

struct MovieDetailDTO: Decodable {
    let movieCode: String
    let title: String
    let openingDay: String
    let productionYear: String
    let playTime: String
    let genre: String
    let directorsName: String
    let actorsName: String
    let watchGrade: String

    enum CodingKeys: String, CodingKey {
        case movieCode = "movieCd"
        case title = "movieNmEn"
        case openingDay = "openDt"
        case productionYear = "prdtYear"
        case playTime = "showTm"
        case genre = "genreNm"
        case directorsName = "directors"
        case actorsName = "actors"
        case watchGrade = "watchGradeNm"
    }
}
