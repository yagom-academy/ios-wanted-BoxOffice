//
//  MovieListViewModel.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import Foundation

final class MovieListViewModel {
    private let fetchMovieListUseCase = FetchMovieListUseCase()
    private var pageToLoad = 0
    var movieOverviewList = [MovieOverview]()
    var dayType: DayType = .weekdays

    var reloadMovieListTableView: (() -> Void)?

    func viewDidLoad() {
        fetchMovieList()
        reloadMovieListTableView?()
    }

    func dayTypeSegmentValueChanged(value: MovieListSegment) {
        switch value {
        case .day:
            dayType = .weekdays
        case .weekDaysAndWeekend:
            dayType = .weekends
        }

        fetchMovieList()
        reloadMovieListTableView?()
    }

    private func fetchMovieList() {
        fetchMovieListUseCase.execute(page: pageToLoad, dayType: dayType) { [weak self] result in
            switch result {
            case .success(let movieOverviewList):
                self?.movieOverviewList = movieOverviewList
            case .failure(let error):
                print(error)
            }
        }
    }
}

enum MovieListSegment {
    case day
    case weekDaysAndWeekend
}
