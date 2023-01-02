//
//  FetchMovieListUseCase.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import Foundation

final class FetchMovieListUseCase {
    private let repository: MovieListRepositoryInterface

    init(repository: MovieListRepositoryInterface) {
        self.repository = repository
    }

    func execute(page: Int, dayType: DayType, completion: @escaping (Result<[MovieOverview], Error>) -> Void) {
        repository.fetchMovieList(page: page, dayType: dayType) { result in
            switch result {
            case .success(let movieList):
                completion(.success(movieList))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
