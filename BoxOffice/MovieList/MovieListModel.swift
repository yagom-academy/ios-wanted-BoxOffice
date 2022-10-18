//
//  MovieListModel.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/18.
//

import Foundation

struct MovieListModel {
    let movieEntity: DailyBoxOfficeList
    
    var rank: String {
        return movieEntity.rank
    }
    
    var movieName: String {
        return movieEntity.movieNm
    }
    
    var openDate: String {
        return movieEntity.openDt
    }
    
    var audienceCount: String {
        return movieEntity.audiCnt
    }
    
    var rankOldAndNew: String {
        return movieEntity.rankOldAndNew.rawValue
    }
    
    var audienceInten: String {
        guard let strToInt = Int(movieEntity.audiCnt) else { return "0" }
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let commaAudience = formatter.string(from: NSNumber(value: strToInt)) else { return "" }
        return commaAudience + "명"
    }
    
}
