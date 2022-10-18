//
//  MovieDetailModel.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/18.
//

import Foundation

struct MovieDetailModel {
    let movieEntity: DailyBoxOfficeList
    let detailEntity: MovieInfo
    
    var rank: String {
        return movieEntity.rank
    }
    
    var movieName: String {
        return detailEntity.movieNm
    }
    
    var movieNameEng: String {
        return detailEntity.movieNmOg
    }
    
    var openDate: String {
        return detailEntity.openDt
    }
    
    var audienceCount: String {
        guard let strToInt = Int(movieEntity.audiCnt) else { return "0" }
        return commaFormatter(strToInt) + "명"
    }
    
    var rankOldAndNew: String {
        return movieEntity.rankOldAndNew.rawValue
    }
    
    var audienceInten: String {
        guard let strToInt = Int(movieEntity.audiInten) else { return "0" }
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
