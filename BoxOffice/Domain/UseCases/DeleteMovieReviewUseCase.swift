//
//  DeleteMovieReviewUseCase.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import Foundation

final class DeleteMovieReviewUseCase {
    private let repository: MovieDetailRepositoryInterface

    init(repository: MovieDetailRepositoryInterface = MovieDetailRepository()) {
        self.repository = repository
    }

    func execute(review: MovieReview, completion: @escaping (Result<Void, Error>) -> Void) {
        repository.deleteMovieReview(review: review) { result in
            switch result {
            case .success:
                completion(.success(()))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
