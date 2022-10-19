//
//  MovieDetailModel.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/18.
//

import Foundation

struct MovieDetailModel {
    let movieModel: MovieListModel
    let detailEntity: MovieInfo

    var rank: String {
        return movieModel.rank
    }

    var movieName: String {
        return detailEntity.movieNm
    }

    var movieNameEng: String {
        return detailEntity.movieNmEn
    }

    var openDate: String {
        return detailEntity.openDt + " 개봉"
    }

    var audienceCount: String {
        return movieModel.audienceCount
    }
    
    var rankOldAndNew: String {
        return movieModel.rankOldAndNew
    }

    var audienceInten: String {
        return movieModel.audienceInten
    }

    var productYear: String {
        return detailEntity.prdtYear
    }

    var showTime: String {
        return detailEntity.showTm + "분"
    }

    var genres: String {
        return detailEntity.genres.map { $0.genreNm }.joined(separator: " | ")
    }

    var directors: String {
        return detailEntity.directors.map { $0.peopleNm }.joined(separator: ", ")
    }

    var actors: String {
        return detailEntity.actors.map { $0.peopleNm }.joined(separator: ", ")
    }

    var watchGrade: String {
        return detailEntity.audits.first?.watchGradeNm ?? "관람가 정보없음"
    }
}
