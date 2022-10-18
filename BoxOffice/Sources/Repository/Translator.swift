//
//  Translator.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/18.
//

import Foundation

enum Translator {
    static func translate(_ response: DailyBoxOfficeListResponse) -> [BoxOffice] {
        let boxOfficeList = response.boxOfficeResult.dailyBoxOfficeList
        var result = [BoxOffice]()
        boxOfficeList.forEach {
            guard
                let rank = Int($0.rank),
                let rankInten = Int($0.rankInten),
                let rankOldAndNew = BoxOffice.RankType(rawValue: $0.rankOldAndNew),
                let audienceCount = Int($0.audiCnt),
                let audienceInten = Int($0.audiInten),
                let audienceChange = Int($0.audiChange),
                let audienceAccumulation = Int($0.audiAcc)
            else { return }
            result.append(
                BoxOffice(
                    rank: rank,
                    rankInten: rankInten,
                    rankOldAndNew: rankOldAndNew,
                    movieCode: $0.movieCd,
                    movieName: $0.movieNm,
                    openDate: $0.openDt,
                    audienceCount: audienceCount,
                    audienceInten: audienceInten,
                    audienceChange: audienceChange,
                    audienceAccumulation: audienceAccumulation)
            )
        }
        return result
    }
    
    static func translate(_ response: WeeklyBoxOfficeListResponse) -> [BoxOffice] {
        let boxOfficeList = response.boxOfficeResult.weeklyBoxOfficeList
        var result = [BoxOffice]()
        boxOfficeList.forEach {
            guard
                let rank = Int($0.rank),
                let rankInten = Int($0.rankInten),
                let rankOldAndNew = BoxOffice.RankType(rawValue: $0.rankOldAndNew),
                let audienceCount = Int($0.audiCnt),
                let audienceInten = Int($0.audiInten),
                let audienceChange = Int($0.audiChange),
                let audienceAccumulation = Int($0.audiAcc)
            else { return }
            result.append(
                BoxOffice(
                    rank: rank,
                    rankInten: rankInten,
                    rankOldAndNew: rankOldAndNew,
                    movieCode: $0.movieCd,
                    movieName: $0.movieNm,
                    openDate: $0.openDt,
                    audienceCount: audienceCount,
                    audienceInten: audienceInten,
                    audienceChange: audienceChange,
                    audienceAccumulation: audienceAccumulation)
            )
        }
        return result
    }
}
