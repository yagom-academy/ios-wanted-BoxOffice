//
//  MovieListItemViewModel.swift
//  BoxOffice
//
//  Created by channy on 2022/10/19.
//

import Foundation

struct MoviesListItemViewModel {
    let rank: String
    let movieNm: String
    let openDt: String
    let audiAcc: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
}

extension MoviesListItemViewModel {
    func getRankString(_ rank: String) -> String {
        return rank + "위"
    }
    
    func isNewLabelHidden(_ new: String) -> Bool {
        return !(new == "NEW")
    }
    
    func isPlus(_ text: String) -> Int {
        if text.contains("-") {
            return -1
        } else if text == "0" {
            return 0
        } else {
            return 1
        }
    }
    
    func getDateString(_ date: String) -> String {
        let ret = date.replacingOccurrences(of: "-", with: ".")
        return ret + " 개봉"
    }
}
