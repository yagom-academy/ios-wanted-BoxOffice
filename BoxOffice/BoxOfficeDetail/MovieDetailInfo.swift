//
//  MoviewDetailInfo.swift
//  BoxOffice
//
//  Created by Baek on 2023/01/03.
//

struct MovieDetailInfo: Decodable {
    let movieNm: String
    let movieNmEn: String
    let prdtYear: String
    let showTm: String
    let openDt: String
    let genreNm: String
    let directors: String
    let peopleNm: String
    let actros: String
    //let peopleNm: String
    let auditNo: String
}
