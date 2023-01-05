//
//  MovieListViewModel.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

final class MovieListViewModel {
    private let apiService = APIService()
    
    func fetch(date: String, completion: @escaping (([MovieEssentialInfo]) -> Void)) {
        var movies: [MovieEssentialInfo] = []
        fetchBoxOffice(date: date) { (boxOffice) in
            boxOffice.boxOfficeResult.dailyBoxOfficeList.forEach { movie in
                var boxOfficeInfo = MovieEssentialInfo()
                boxOfficeInfo.movieNm = movie.movieNm
                boxOfficeInfo.boxOfficeRank = movie.rank
                boxOfficeInfo.showCnt = movie.showCnt
                boxOfficeInfo.salesChange = movie.salesChange
                boxOfficeInfo.openDate = movie.openDt
                boxOfficeInfo.movieCd = movie.movieCd
                movies.append(boxOfficeInfo)
                if movies.count == 10 {
                    completion(movies)
                }
            }
        }
    }
    
    private func configureMovieInfo(completion: @escaping (() -> Void)) {
        
    }
    
    private func fetchBoxOffice(date: String, completion: @escaping ((BoxOfficeEntity) -> Void)) {
        self.apiService.fetchBoxOffice(date: date) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchPoster(title: String, completion: @escaping ((MovieEntity)) -> Void) {
        self.apiService.fetchPoster(title: title) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func fetchMovieDetail(movieCd: String, completion: @escaping ((MovieInfoEntity)) -> Void) {
        self.apiService.fetchMovieDetail(movieCd: movieCd) { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
