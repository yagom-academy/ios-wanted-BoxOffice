//
//  MovieDetail.swift
//  BoxOffice
//
//  Created by channy on 2022/10/22.
//

import Foundation

struct MovieDetail: Codable {
    let prdtYear: String
    let showTm: String
    let genreNm: [String]
    let directorsNm: [String]
    let actorsNm: [String]
    let watchGradeNm: [String]
}
