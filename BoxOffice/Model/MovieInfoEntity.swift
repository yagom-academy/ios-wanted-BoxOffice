//
//  MovieInfoEntity.swift
//  BoxOffice
//
//  Created by 이은찬 on 2023/01/03.
//

import Foundation

struct MovieInfoEntity: Decodable {
    let movieInfoResult: MovieInfoResult
    
    struct MovieInfoResult: Decodable {
        let movieInfo: MovieInfo
        
        struct MovieInfo: Decodable {
            let movieNmEn: String
            let prdtYear: String
            let openDt: String
            let showTm: String
            let genres: [Genres]
            let directors: [Directors]
            let actors: [Actors]
            let audits: [Audits]

            struct Genres: Decodable { let genreNm: String }
            struct Directors: Decodable { let peopleNm: String }
            struct Actors: Decodable { let peopleNm: String }
            struct Audits: Decodable { let watchGradeNm: String }
        }
    }
}
