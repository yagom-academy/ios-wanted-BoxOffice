//
//  FilmDetails.swift
//  BoxOffice
//
//  Created by 천승희 on 2023/01/03.
//

import Foundation

struct FilmDetails: Decodable {
    let dailyBoxOfficeList: DailyBoxOfficeList
    let prdtYear: String
    let openDt: String
    let showTm: String
    let genreNm: String
    let directors: [PeopleName]
    let actors: [PeopleName]
    let watchGradeNm: String
}
