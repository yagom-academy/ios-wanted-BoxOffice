//
//  MovieDetailViewModel.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/18.
//

import Foundation

final class MovieDetailViewModel {
    
    let detailTitleList = ["장르", "관람등급", "감독", "출연", "누적관객"]
    
    var movieDetailModel: MovieDetailModel? {
        didSet {
            guard let data = movieDetailModel else { return }
            self.updateMovieDetail(data)
            
        }
    }
    
    var movieListModel: MovieListModel? {
        didSet {
            guard let data = movieListModel else { return }
            requestMovieDetail(data: data)
            movieID = data.movieCode
        }
    }
    
    var movieID: String = ""
    
    var reviewList: [Review] = []{
        didSet {
            print("리뷰 리스트 \(reviewList)")
        }
    }
    
    
    private let repository: MovieReqeustable
    
    var loadingStart: (() -> Void) = {}
    var loadingEnd: (() -> Void) = {}
    var updateMovieDetail: ((MovieDetailModel) -> ()) = { _ in }
    
    init() {
        self.repository = MovieRepository()
    }
    
    func requestMovieDetail(data: MovieListModel) {
        self.loadingStart()
        repository.fetchMovieDetail(movieCode: data.movieCode) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success(let entity):
                self.movieDetailModel = MovieDetailModel(movieModel: data,
                                                         detailEntity: entity.movieInfoResult.movieInfo)
                self.loadingEnd()
            case .failure(let error):
                fatalError("🚨Error: \(error)")
            }
        }
    }
}
