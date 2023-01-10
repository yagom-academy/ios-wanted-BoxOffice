//
//  FetchReviewImageUseCase.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/05.
//

import UIKit

final class FetchReviewImageUseCase {
    private let repository: MovieDetailRepositoryInterface

    init(repository: MovieDetailRepositoryInterface = MovieDetailRepository()) {
        self.repository = repository
    }

    func execute(imageURL: String, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable? {
        return repository.fetchReviewImage(imageURL: imageURL) { result in
            completion(result)
        }
    }
}
