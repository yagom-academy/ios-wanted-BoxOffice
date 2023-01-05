//
//  MovieEssentialInfo.swift
//  BoxOffice
//
//  Created by 이은찬 on 2023/01/04.
//

import Foundation

struct MovieEssentialInfo {
    var poster: String?  // omdb
    var boxOfficeRank: String?
    var movieNm: String?
    var movieNmEn: String?
    var movieCd: String?
    var openDate: String?// 상세
    var showCnt: String?
    var salesChange: String?
    var rankOldAndNew: RankOldAndNew?
    var prdtYear: String? // 상세
    var openYear: String? // 상세
    var runtime: String? // 상세
    var genre: String? // omdb
    var director: String? // 상세
    var actors: String? // 상세
    var watchGrade: String? // 상세
}
