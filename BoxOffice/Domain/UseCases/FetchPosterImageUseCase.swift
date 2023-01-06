//
//  FetchPosterImageUseCase.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/05.
//

import UIKit

final class FetchPosterImageUseCase {
    private let repository: MovieDetailRepositoryInterface

    init(repository: MovieDetailRepositoryInterface = MovieDetailRepository()) {
        self.repository = repository
    }

    func execute(englishMovieTitle: String, year: String, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable? {
        let task = repository.fetchMoviePoster(englishMovieName: englishMovieTitle, year: year) { result in
            completion(result)
        }

        return task
    }
}
