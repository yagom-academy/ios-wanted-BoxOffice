//
//  MoviesDetailResponseKofic+Mapping.swift
//  BoxOffice
//
//  Created by channy on 2022/10/22.
//

import Foundation

struct MoviesDetailResponseKoficList: Decodable {
    let movieInfoResult: MoviesDetailReponseKoficSubList
}

struct MoviesDetailReponseKoficSubList: Decodable {
    let movieInfo: MoviesDetailResponseKofic
}

struct MoviesDetailResponseKofic: Decodable {
    let prdtYear: String
    let showTm: String
    let genres: [GenresKofic]
    let directors: [DirectorsKofic]
    let actors: [ActorsKofic]
    let audits: [AuditsKofic]
}

struct GenresKofic: Decodable {
    let genreNm: String
}

struct DirectorsKofic: Decodable {
    let peopleNm: String
}

struct ActorsKofic: Decodable {
    let peopleNm: String
}

struct AuditsKofic: Decodable {
    let watchGradeNm: String
}

extension MoviesDetailResponseKofic {
    func toDomain() -> MovieDetail {
        let genres = genres.map { $0.genreNm }
        let directors = directors.map { $0.peopleNm }
        let actors = actors.map { $0.peopleNm }
        let grade = audits.map { $0.watchGradeNm }
        
        return .init(prdtYear: prdtYear, showTm: showTm, genreNm: genres, directorsNm: directors, actorsNm: actors, watchGradeNm: grade)
    }
}
