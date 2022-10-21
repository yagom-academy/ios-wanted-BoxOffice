//
//  Translator.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/18.
//

import Foundation

enum Translator {
    static func translate(_ response: DailyBoxOfficeListResponse) -> [Movie] {
        let boxOfficeList = response.boxOfficeResult.dailyBoxOfficeList
        var result = [Movie]()
        boxOfficeList.forEach {
            guard
                let openDate = $0.openDt.asDate(),
                let rank = Int($0.rank),
                let rankInten = Int($0.rankInten),
                let rankOldAndNew = BoxOfficeInfo.RankType(rawValue: $0.rankOldAndNew),
                let audienceAccumulation = Int($0.audiAcc)
            else { return }
            result.append(
                Movie(
                    movieCode: $0.movieCd,
                    movieName: $0.movieNm,
                    openDate: openDate,
                    boxOfficeInfo: BoxOfficeInfo(
                        rank: rank,
                        rankInten: rankInten,
                        rankOldAndNew: rankOldAndNew,
                        audienceAccumulation: audienceAccumulation))
            )
        }
        return result
    }
    
    static func translate(_ response: WeeklyBoxOfficeListResponse) -> [Movie] {
        let boxOfficeList = response.boxOfficeResult.weeklyBoxOfficeList
        var result = [Movie]()
        boxOfficeList.forEach {
            guard
                let openDate = $0.openDt.asDate(),
                let rank = Int($0.rank),
                let rankInten = Int($0.rankInten),
                let rankOldAndNew = BoxOfficeInfo.RankType(rawValue: $0.rankOldAndNew),
                let audienceAccumulation = Int($0.audiAcc)
            else { return }
            result.append(
                Movie(
                    movieCode: $0.movieCd,
                    movieName: $0.movieNm,
                    openDate: openDate,
                    boxOfficeInfo: BoxOfficeInfo(
                        rank: rank,
                        rankInten: rankInten,
                        rankOldAndNew: rankOldAndNew,
                        audienceAccumulation: audienceAccumulation))
            )
        }
        return result
    }
    
    static func translate(_ response: MovieDetailResponse) throws -> MovieDetailInfo {
        let info = response.movieInfoResult.movieInfo
        guard
            let showTime = Int(info.showTm),
            let audit = info.audits.first?.watchGradeNm
        else { throw TranslatorError.castingError }
        return MovieDetailInfo(
            movieNameEnglish: info.movieNmEn,
            showTime: showTime,
            productionYear: info.prdtYear,
            genres: info.genres.map { $0.genreNm },
            directors: info.directors.map { $0.peopleNm },
            actors: info.actors.map { $0.peopleNm },
            audit: audit)
    }
    
    static func translate(_ response: MoviePosterResponse) throws -> String {
        guard let poster = response.poster else { throw TranslatorError.zeroByteData }
        return poster
    }
}
