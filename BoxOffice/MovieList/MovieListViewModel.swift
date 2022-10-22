//
//  MovieListViewModel.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/18.
//

import Foundation

final class MovieListViewModel {
    
    private let repository: MovieReqeustable
    var movieList: [MovieListModel] = .init([])
    var boxofficeType: String = ""
    var showRange: String = ""
    var movieCode: String = ""
   
    var loadingStart: (() -> Void) = {}
    var loadingEnd: (() -> Void) = {}
    var updateMovieList: (() -> Void) = {}
    
    init() {
        self.repository = MovieRepository()
    }
    
    func requestMovieList() {
        self.loadingStart()
        repository.fetchMovieList(targetDate: getYesterday()) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let entity):
                self.boxofficeType = entity.boxOfficeResult.boxofficeType
                self.showRange = entity.boxOfficeResult.showRange
                let list = entity.boxOfficeResult.dailyBoxOfficeList
                list.forEach {
                    self.movieList.append(MovieListModel(movieEntity: $0))
                }
                self.updateMovieList()
                self.loadingEnd()
            case .failure(let error):
                fatalError("🚨Error: \(error)")
            }
        }
    }
    
    func getMovieListCount() -> Int {
        return movieList.count
    }
    
    func getYesterday() -> String {
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())!
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        let result = formatter.string(from: yesterday)
        print("어제", result)
        return result
    }
}

