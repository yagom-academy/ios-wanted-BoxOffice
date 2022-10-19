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
        return detailEntity.openDt
    }

    var audienceCount: String {
        guard let strToInt = Int(movieModel.audienceCount) else { return "0" }
        return commaFormatter(strToInt) + "명"
    }

    var rankOldAndNew: String {
        return movieModel.rankOldAndNew
    }

    var audienceInten: String {
        guard let strToInt = Int(movieModel.audienceInten) else { return "0" }
        return commaFormatter(strToInt) + "명"
    }

    var productYear: String {
        return detailEntity.prdtYear
    }

    var showTime: String {
        return detailEntity.showTm
    }

    var genres: [String] {
        return detailEntity.genres.map { $0.genreNm }
    }

    var directors: [String] {
        return detailEntity.directors.map { $0.peopleNm }
    }

    var actors: [String] {
        return detailEntity.actors.map { $0.peopleNm }
    }

    var watchGrade: String {
        return detailEntity.audits.first?.watchGradeNm ?? "관람가 정보없음"
    }
}
