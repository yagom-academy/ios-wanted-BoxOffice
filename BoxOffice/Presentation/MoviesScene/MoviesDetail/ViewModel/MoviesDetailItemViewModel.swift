//
//  MoviesDetailViewModel.swift
//  BoxOffice
//
//  Created by channy on 2022/10/22.
//

import Foundation

struct MoviesDetailItemViewModel {
    let rank: String
    let movieNm: String
    let openDt: String
    let audiAcc: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
    
    var prdtYear: String = ""
    var showTm: String = ""
    var genreNm: [String] = []
    var directorsNm: [String] = []
    var actorsNm: [String] = []
    var watchGradeNm: [String] = []
}
