//
//  FetchMovieDetailUseCase.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/02.
//

import Foundation

final class FetchMovieDetailUseCase {
    private let repository: MovieDetailRepositoryInterface
    
    init(repository: MovieDetailRepositoryInterface = MockMovieDetailRepository()) {
        self.repository = repository
    }
    
    func execute(movieCode: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        repository.fetchMovieDetail(movieCode: movieCode) { result in
            switch result {
            case .success(let movieDetail):
                completion(.success(movieDetail))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
