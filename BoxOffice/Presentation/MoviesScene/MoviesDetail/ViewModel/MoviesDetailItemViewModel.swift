//
//  MoviesDetailViewModel.swift
//  BoxOffice
//
//  Created by channy on 2022/10/22.
//

import Foundation

struct MoviesDetailItemViewModel {
    let rank: String
    let movieNm: String
    let openDt: String
    let audiAcc: String
    let rankInten: String
    let rankOldAndNew: String
    let movieCd: String
    
    var prdtYear: String = ""
    var showTm: String = ""
    var genreNm: [String] = []
    var directorsNm: [String] = []
    var actorsNm: [String] = []
    var watchGradeNm: [String] = []
}

extension MoviesDetailItemViewModel {
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
    
    func getGenreString(_ genres: [String]) -> String {
        guard !genres.isEmpty else { return "N/A" }
        var ret = ""
        genres.forEach { ret += ($0 + ", ") }
        
        let endIndex = ret.index(ret.endIndex, offsetBy: -2)
        ret = String(ret[..<endIndex])
        
        return ret
    }
    
    func getShowTimeString(_ timeString: String) -> String {
        guard let time = Int(timeString) else { return "N/A" }
        if time < 60 {
            return String(time) + " 분"
        } else {
            let hour = String(Int(Double(time/60)))
            let min = String(time%60)
            return String(hour) + "시간 " + String(min) + "분"
        }
    }
    
    func getDateString(_ date: String) -> String {
        let ret = date.replacingOccurrences(of: "-", with: ".")
        return ret + " 개봉"
    }
    
    func getGradeString(_ grade: [String]) -> String {
        guard !grade.isEmpty else { return "N/A" }
        return grade[0]
    }
    
    func getProduceDateString(_ prod: String) -> String {
        return prod + "년 제작"
    }
    
    func getAudienceString(_ audience: String) -> String {
        return audience + "명"
    }
    
    func getDirectorString(_ directors: [String]) -> String {
        guard !directors.isEmpty else { return "N/A" }
        var ret = ""
        directors.forEach { ret += ($0 + ", ") }
        let endIndex = ret.index(ret.endIndex, offsetBy: -2)
        ret = String(ret[..<endIndex])
        
        return ret
    }
    
    func getActorString(_ actors: [String]) -> String {
        guard !actors.isEmpty else { return "N/A" }
        var ret = ""
        
        // 배우는 최대 5명까지 표시
        for i in 0..<min(actors.count, 5) {
            ret += (actors[i] + ", ")
        }
        let endIndex = ret.index(ret.endIndex, offsetBy: -2)
        ret = String(ret[..<endIndex])
        
        return ret
    }
}
