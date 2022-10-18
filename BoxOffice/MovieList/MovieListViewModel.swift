//
//  MovieListViewModel.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/18.
//

import Foundation

final class MovieListViewModel {
    
    private let repository: MovieReqeustable
    let targetDate = "20221017"
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
    
    func requestMovieList(target: String) {
        self.loadingStart()
        repository.fetchMovieList(targetDate: targetDate) { [weak self] result in
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
                print("💎 \(self.movieList)")
            case .failure(let error):
                fatalError("🚨Error: \(error)")
            }
        }
    }
    
    func getMovieListCount() -> Int {
        return movieList.count
    }
}
