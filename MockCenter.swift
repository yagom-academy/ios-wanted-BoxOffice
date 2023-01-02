//
//  MockCenter.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/02.
//

import Foundation

final class MockMovieListRepository: MovieListRepositoryInterface {
    func fetchMovieList(page: Int, dayType: DayType, completion: @escaping (Result<[MovieOverview], Error>) -> Void) {
    }
}

final class MockMovieDetailRepository: MovieDetailRepositoryInterface {
    func fetchMovieDetail(of movieCode: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        
    }

    func fetchMovieReview(movieCode: String, completion: @escaping (Result<[MovieReview], Error>) -> Void) {

    }

    func deleteMovieReview(review: MovieReview, completion: @escaping (Result<Void, Error>) -> Void) {

    }
}
