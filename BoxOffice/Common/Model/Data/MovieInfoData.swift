//
//  MovieInfoData.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/22.
//

import Foundation

struct MovieInfoData {
    let rank: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
    let movieNm: String
    let openDt: String
    let audiCnt: String
    
    let prdtYear: String
    let showTm: String
    let genres: [Genres]
    let directors: [Directors]
    let actors: [Actors]
    let audits: [Audits]
    
    init(_ movieInfoResponse: MovieInfoResponse, with boxOfficeResponse: BoxOfficeResponse) {
        self.rank = boxOfficeResponse.rank
        self.rankInten = boxOfficeResponse.rankInten
        self.rankOldAndNew = boxOfficeResponse.rankOldAndNew
        self.movieCd = boxOfficeResponse.movieCd
        self.movieNm = boxOfficeResponse.movieNm
        self.openDt = boxOfficeResponse.openDt
        self.audiCnt = boxOfficeResponse.audiCnt
        
        self.prdtYear = movieInfoResponse.prdtYear
        self.showTm = movieInfoResponse.showTm
        self.genres = movieInfoResponse.genres
        self.directors = movieInfoResponse.directors
        self.actors = movieInfoResponse.actors
        self.audits = movieInfoResponse.audits
    }
}
