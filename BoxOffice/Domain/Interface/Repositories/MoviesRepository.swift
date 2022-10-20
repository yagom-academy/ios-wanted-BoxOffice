//
//  MoviesRepository.swift
//  BoxOffice
//
//  Created by channy on 2022/10/19.
//

import Foundation

protocol MoviesRepository {
    func fetchMoviesList(completion: @escaping ((Result<Movie, Error>) -> Void))
}

final class DefaultMoviesRepository {
    
    init() { }
    
}

extension DefaultMoviesRepository: MoviesRepository {
    func fetchMoviesList(completion: @escaping ((Result<Movie, Error>) -> Void)) {
        <#code#>
    }
}
