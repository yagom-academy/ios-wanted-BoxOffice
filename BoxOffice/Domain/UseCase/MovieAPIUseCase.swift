//
//  MovieAPIUseCase.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/05.
//

import Foundation

struct MovieAPIUseCase {
    
    func requestDailyData(with date: String, in dataList: Observable<[MovieCellData]>) async throws {
        dataList.value = []
        let boxOfficeList = try await fetchDailyBoxOfficeData(with: date)
        for boxOffice in boxOfficeList {
            Task {
                guard let result = try await fetchMovieDetailInfo(with: boxOffice.movieCd) else { return }
                let movieEnglishName = result.movieNmEn
                let movieOpenYear = String(result.openDt.prefix(4))
                do {
                    let posterURL1 = try await fetchMoviePosterURL(with: movieEnglishName, year: movieOpenYear)
                    appendCellData(to: dataList, boxOffice: boxOffice, openDate: result.openDt,
                                       posterURL: URL(string: posterURL1 ?? ""))
                } catch {
                    appendCellData(to: dataList, boxOffice: boxOffice, openDate: result.openDt,
                                       posterURL: nil)
                }
            }
        }
    }
    
    func requestAllWeekData(with date: String, in dataList: Observable<[MovieCellData]>) async throws {
        dataList.value = []
        let boxOfficeList = try await fetchAllWeekBoxOfficeData(with: date)
        for boxOffice in boxOfficeList {
            Task {
                guard let result = try await fetchMovieDetailInfo(with: boxOffice.movieCd) else { return }
                let movieEnglishName = result.movieNmEn
                let movieOpenYear = String(result.openDt.prefix(4))
                
                do {
                    let posterURL1 = try await fetchMoviePosterURL(with: movieEnglishName, year: movieOpenYear)
                    appendCellData(to: dataList, boxOffice: boxOffice, openDate: result.openDt,
                                   posterURL: URL(string: posterURL1 ?? ""))
                } catch {
                    appendCellData(to: dataList, boxOffice: boxOffice, openDate: result.openDt,
                                   posterURL: nil)
                }
            }
        }
    }
    
    func requestWeekEndData(with date: String, in dataList: Observable<[MovieCellData]>) async throws {
        dataList.value = []
        let boxOfficeList = try await fetchWeekEndBoxOfficeData(with: date)
        for boxOffice in boxOfficeList {
            Task {
                guard let result = try await fetchMovieDetailInfo(with: boxOffice.movieCd) else { return }
                let movieEnglishName = result.movieNmEn
                let movieOpenYear = String(result.openDt.prefix(4))
                
                do {
                    let posterURL1 = try await fetchMoviePosterURL(with: movieEnglishName, year: movieOpenYear)
                    appendCellData(to: dataList, boxOffice: boxOffice, openDate: result.openDt,
                                   posterURL: URL(string: posterURL1 ?? ""))
                } catch {
                    appendCellData(to: dataList, boxOffice: boxOffice, openDate: result.openDt,
                                   posterURL: nil)
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
    
    func appendCellData(to list: Observable<[MovieCellData]>, boxOffice: BoxOffice,
                        openDate: String,posterURL: URL?) {
        list.value.append(
            MovieCellData(
                uuid: UUID(),
                posterURL: posterURL ?? nil,
                currentRank: boxOffice.rank,
                totalAudience: boxOffice.audiAcc,
                title: boxOffice.movieNm,
                openDate: openDate,
                isNewEntry: boxOffice.rankOldAndNew == "NEW",
                rankChange: boxOffice.rankInten
            )
        )
    }
}
