//
//  MovieInfoData.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/22.
//

import Foundation

struct MovieInfoData {
    let movieCd: String
    let prdtYear: String
    let showTm: String
    let genres: [Genres]
    let directors: [Directors]
    let actors: [Actors]
    let audits: [Audits]
    
    init(_ movieInfoResponse: MovieInfoResponse) {
        self.movieCd = movieInfoResponse.movieCd
        self.prdtYear = movieInfoResponse.prdtYear
        self.showTm = movieInfoResponse.showTm
        self.genres = movieInfoResponse.genres
        self.directors = movieInfoResponse.directors
        self.actors = movieInfoResponse.actors
        self.audits = movieInfoResponse.audits
    }
}

extension MovieInfoData: Equatable {
    static func == (lhs: MovieInfoData, rhs: MovieInfoData) -> Bool {
        return lhs.movieCd == rhs.movieCd
    }
}
