//
//  MoviesRepository.swift
//  BoxOffice
//
//  Created by channy on 2022/10/19.
//

import Foundation

protocol MoviesRepository {
    func fetchMoviesList(completion: @escaping ((Result<[Movie], RepositoryError>) -> Void))
    func fetchMoviesDetail(movieId movieCd: String, completion: @escaping ((Result<MovieDetail, RepositoryError>) -> Void))
}
