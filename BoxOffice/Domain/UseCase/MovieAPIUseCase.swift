//
//  MovieAPIUseCase.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/05.
//

import Foundation

struct MovieAPIUseCase {
    private let imageCacheManager = URLCacheManager()
    
    func requestDailyData(with date: String, in dataList: Observable<[MovieData]>) async throws {
        dataList.value = []
        let boxOfficeList = try await fetchDailyBoxOfficeData(with: date)
        for boxOffice in boxOfficeList {
            Task {
                guard let movieInfo = try await fetchMovieDetailInfo(with: boxOffice.movieCd) else { return }
                let movieEnglishName = movieInfo.movieNmEn
                let movieOpenYear = String(movieInfo.openDt.prefix(4))
                do {
                    let posterURL1 = try await fetchMoviePosterURL(with: movieEnglishName, year: movieOpenYear)
                    try await appendCellData(
                        to: dataList,
                        boxOffice: boxOffice,
                        movieInfo: movieInfo,
                        posterURL: URL(string: posterURL1 ?? "")
                    )
                } catch {
                    try await appendCellData(
                        to: dataList,
                        boxOffice: boxOffice,
                        movieInfo: movieInfo,
                        posterURL: nil
                    )
                }
            }
        }
    }
    
    func requestAllWeekData(with date: String, in dataList: Observable<[MovieData]>) async throws {
        dataList.value = []
        let boxOfficeList = try await fetchAllWeekBoxOfficeData(with: date)
        for boxOffice in boxOfficeList {
            Task {
                guard let movieInfo = try await fetchMovieDetailInfo(with: boxOffice.movieCd) else { return }
                let movieEnglishName = movieInfo.movieNmEn
                let movieOpenYear = String(movieInfo.openDt.prefix(4))
                
                do {
                    let posterURL1 = try await fetchMoviePosterURL(with: movieEnglishName, year: movieOpenYear)
                    try await appendCellData(
                        to: dataList,
                        boxOffice: boxOffice,
                        movieInfo: movieInfo,
                        posterURL: URL(string: posterURL1 ?? "")
                    )
                } catch {
                    try await appendCellData(
                        to: dataList,
                        boxOffice: boxOffice,
                        movieInfo: movieInfo,
                        posterURL: nil
                    )
                }
            }
        }
    }
    
    func requestWeekEndData(with date: String, in dataList: Observable<[MovieData]>) async throws {
        dataList.value = []
        let boxOfficeList = try await fetchWeekEndBoxOfficeData(with: date)
        for boxOffice in boxOfficeList {
            Task {
                guard let movieInfo = try await fetchMovieDetailInfo(with: boxOffice.movieCd) else { return }
                let movieEnglishName = movieInfo.movieNmEn
                let movieOpenYear = String(movieInfo.openDt.prefix(4))
                
                do {
                    let posterURL1 = try await fetchMoviePosterURL(with: movieEnglishName, year: movieOpenYear)
                    try await appendCellData(
                        to: dataList,
                        boxOffice: boxOffice,
                        movieInfo: movieInfo,
                        posterURL: URL(string: posterURL1 ?? "")
                    )
                } catch {
                    try await appendCellData(
                        to: dataList,
                        boxOffice: boxOffice,
                        movieInfo: movieInfo,
                        posterURL: nil
                    )
                }
            }
        }
    }
}

private extension MovieAPIUseCase {
    
    func fetchAllWeekBoxOfficeData(with date: String) async throws -> [BoxOffice] {
        let searchWeeklyBoxOfficeListAPI = SearchWeeklyBoxOfficeListAPI(
            date: date,
            weekOption: .allWeek
        )
        let result = try await searchWeeklyBoxOfficeListAPI.execute()
        guard let weeklyBoxOfficeList = result?.boxOfficeResult.weeklyBoxOfficeList else { return [] }
        return weeklyBoxOfficeList
    }
    
    func fetchWeekEndBoxOfficeData(with date: String) async throws -> [BoxOffice] {
        let searchWeeklyBoxOfficeListAPI = SearchWeeklyBoxOfficeListAPI(
            date: date,
            weekOption: .weekEnd
        )
        let result = try await searchWeeklyBoxOfficeListAPI.execute()
        guard let weeklyBoxOfficeList = result?.boxOfficeResult.weeklyBoxOfficeList else { return [] }
        return weeklyBoxOfficeList
    }
    
    func fetchDailyBoxOfficeData(with date: String) async throws -> [BoxOffice] {
        let searchDailyBoxOfficeListAPI = SearchDailyBoxOfficeListAPI(
            date: date
        )
        let result = try await searchDailyBoxOfficeListAPI.execute()
        guard let dailyBoxOfficeList = result?.boxOfficeResult.dailyBoxOfficeList else { return [] }
        return dailyBoxOfficeList
    }
    
    func fetchMovieDetailInfo(with movieCode: String) async throws -> MovieInfo? {
        let searchMovieInfoAPI = SearchMovieInfoAPI(movieCode: movieCode)
        let result = try await searchMovieInfoAPI.execute()
        guard let movieInfo = result?.movieInfoResult.movieInfo else { return nil }
        return movieInfo
    }
    
    func fetchMoviePosterURL(with movieName: String, year: String?) async throws -> String? {
        let searchMoviePosterAPI = SearchMoviePosterAPI(movieTitle: movieName, year: year)
        guard let result = try await searchMoviePosterAPI.execute() else { return nil }
        guard let url = result.posterURLString() else { return nil }
        return url
    }
    
    func appendCellData(to list: Observable<[MovieData]>, boxOffice: BoxOffice,
                        movieInfo: MovieInfo, posterURL: URL?) async throws {
        let image = try await imageCacheManager.getImage(with: posterURL)
        list.value.append(
            MovieData(
                uuid: UUID(),
                poster: image,
                currentRank: boxOffice.rank,
                title: boxOffice.movieNm,
                openDate: movieInfo.openDt,
                totalAudience: boxOffice.audiAcc,
                rankChange: boxOffice.rankInten,
                isNewEntry: boxOffice.rankOldAndNew == "New",
                productionYear: movieInfo.prdtYear,
                openYear: String(movieInfo.openDt.prefix(4)),
                showTime: movieInfo.showTm,
                genreName: movieInfo.genres.count > 0 ? movieInfo.genres[0].genreNm : "",
                directorName: movieInfo.directors.count > 0 ? movieInfo.directors[0].peopleNm : "",
                actors: movieInfo.actors.count > 0 ? movieInfo.actors.map { $0.peopleNm } : [] ,
                ageLimit: movieInfo.audits.count > 0 ? movieInfo.audits[0].watchGradeNm : ""
            )
        )
    }
}
