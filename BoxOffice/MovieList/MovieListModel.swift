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
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        let date = formatter.date(from: movieEntity.openDt)
        return formatter.string(from: date!) + " 개봉"
    }
    
    var audienceCount: String {
        guard let strToInt = Int(movieEntity.audiCnt) else { return "0" }
        return commaFormatter(strToInt) + "명"
    }
    
    var rankOldAndNew: String {
        var rank: String = ""
        if Int(movieEntity.rankInten) ?? 0 < 0 {
            rank = "📈 \(movieEntity.rankInten)"
        } else if Int(movieEntity.rankInten) ?? 0 > 0 {
            rank = "📉 \(movieEntity.rankInten)"
        } else {
            rank = "➖"
        }
        switch movieEntity.rankOldAndNew {
        case .new:
            return "NEW"
        case .old:
            return rank
        }
    }
    
    var rankInten: String {
        return movieEntity.rankInten
    }
    
    var movieCode: String {
        return movieEntity.movieCD
    }
}

func commaFormatter(_ num: Int) -> String {
    let formatter = NumberFormatter()
    formatter.numberStyle = .decimal
    guard let commaValue = formatter.string(from: NSNumber(value: num)) else { return "" }
    return commaValue
}
