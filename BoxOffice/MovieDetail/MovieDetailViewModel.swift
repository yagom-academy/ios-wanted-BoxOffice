//
//  MovieDetailViewModel.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/18.
//

import Foundation

final class MovieDetailViewModel {
    
    var movieDetail: MovieInfo?
    let detailTitle = ["개요", "감독", "출연", "관객수", "관람등급", "랭킹"]

    private let repository: MovieReqeustable
    
    var loadingStart: (() -> Void) = {}
    var loadingEnd: (() -> Void) = {}
    var updateMovieDetail: (() -> Void) = {}

    init() {
        self.repository = MovieRepository()
    }
    
    func requestMovieDetail(code: String) {
        self.loadingStart()
        repository.fetchMovieDetail(movieCode: code) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let entity):
                self.movieDetail = entity.movieInfoResult.movieInfo
                self.updateMovieDetail()
                self.loadingEnd()
            case .failure(let error):
                fatalError("🚨Error: \(error)")
            }
        }
    }
}
