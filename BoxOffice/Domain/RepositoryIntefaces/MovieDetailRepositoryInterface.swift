//
//  MovieDetailRepositoryInterface.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/02.
//

import UIKit

protocol MovieDetailRepositoryInterface {
    func fetchMovieDetail(movieCode: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) -> Cancellable?

    func fetchMovieReview(movieCode: String, completion: @escaping (Result<[MovieReview], Error>) -> Void)

    func deleteMovieReview(review: MovieReview, completion: @escaping (Result<Void, Error>) -> Void)

    func fetchMoviePoster(englishMovieName: String, year: String, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable?

    func fetchReviewImage(imageURL: String, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable?
}
