//
//  FetchMovieReviewUseCase.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import Foundation

final class FetchMovieReviewUseCase {
    private let repository: MovieDetailRepositoryInterface

    init(repository: MovieDetailRepositoryInterface = MockMovieDetailRepository()) {
        self.repository = repository
    }

    func execute(movieCode: String, completion: @escaping (Result<MovieReview, Error>) -> Void) {
        repository.fetchMovieReview(movieCode: movieCode) { result in
            switch result {
            case .success(let movieReview):
                completion(.success(movieReview))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
