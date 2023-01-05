//
//  HomeViewModel.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/04.
//

import Foundation

protocol HomeViewModelInput {
    func requestDailyData(with date: String)
    func requestAllWeekData(with date: String)
    func requestWeekEndData(with date: String)
}

protocol HomeViewModelOutput{
    var dailyMovieCellDatas: Observable<[MovieCellData]> { get }
    var allWeekMovieCellDatas: Observable<[MovieCellData]> { get }
    var weekEndMovieCellDatas: Observable<[MovieCellData]> { get }
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {}

final class DefaultHomeViewModel: HomeViewModel {
    private let movieAPIUseCase = MovieAPIUseCase()
    var dailyMovieCellDatas = Observable<[MovieCellData]>([])
    var allWeekMovieCellDatas = Observable<[MovieCellData]>([])
    var weekEndMovieCellDatas = Observable<[MovieCellData]>([])
    
    func requestDailyData(with date: String) {
        movieAPIUseCase.requestDailyData(with: date, in: dailyMovieCellDatas)
    }
    func requestAllWeekData(with date: String) {
        movieAPIUseCase.requestAllWeekData(with: date, in: allWeekMovieCellDatas)
    }
    func requestWeekEndData(with date: String) {
        movieAPIUseCase.requestWeekEndData(with: date, in: weekEndMovieCellDatas)
    }
}
