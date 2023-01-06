//
//  HomeViewModel.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/04.
//

import Foundation

protocol HomeViewModelInput {
    func requestDailyData(with date: String) async throws
    func requestAllWeekData(with date: String) async throws
    func requestWeekEndData(with date: String) async throws
}

protocol HomeViewModelOutput{
    var dailyMovieCellDatas: Observable<[MovieData]> { get }
    var allWeekMovieCellDatas: Observable<[MovieData]> { get }
    var weekEndMovieCellDatas: Observable<[MovieData]> { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {}

final class DefaultHomeViewModel: HomeViewModel {
    private let movieAPIUseCase = MovieAPIUseCase()
    var dailyMovieCellDatas = Observable<[MovieData]>([])
    var allWeekMovieCellDatas = Observable<[MovieData]>([])
    var weekEndMovieCellDatas = Observable<[MovieData]>([])
    
    func requestDailyData(with date: String) async throws {
        try await movieAPIUseCase.requestDailyData(with: date, in: dailyMovieCellDatas)
    }
    func requestAllWeekData(with date: String) async throws {
        try await movieAPIUseCase.requestAllWeekData(with: date, in: allWeekMovieCellDatas)
    }
    func requestWeekEndData(with date: String) async throws {
        try await movieAPIUseCase.requestWeekEndData(with: date, in: weekEndMovieCellDatas)
    }
}
