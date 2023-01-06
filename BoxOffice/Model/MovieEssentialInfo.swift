//
//  MovieEssentialInfo.swift
//  BoxOffice
//
//  Created by 이은찬 on 2023/01/04.
//

import Foundation

struct MovieEssentialInfo: Hashable {
    let posterUrl: String
    let rank: String
    let movieNm: String
    let openDt: String
    let audiAcc: String
    let rankInten: String
    let rankOldAndNew: String
    let prdtYear: String
    let openYear: String
    let showTm: String
    let genres: String
    let directors: [Directors]
    let actors: [Actors]
    let watchGradeNm: String
}
