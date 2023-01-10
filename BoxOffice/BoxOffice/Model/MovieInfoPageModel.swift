//
//  MovieInfoModel.swift
//  BoxOffice
//
//  Created by 유한석 on 2023/01/04.
//

import Foundation

struct MovieInfoPageModel {
    let rank: String
    let movieNm: String
    let openDatDt: String
    let audiCnt: String
    let audiInten: String
    let rankOldAndNew: String
    let prdtYear: String
    let openYearDt: String
    let showTm: String
    let genreNm: String
    let directors: [Director]
    let actors: [Actor]
    let watchGradeNm: String 
    let nations: [Nation]
}
