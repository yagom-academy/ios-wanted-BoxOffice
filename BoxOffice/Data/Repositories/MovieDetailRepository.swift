//
//  MovieDetailRepository.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/04.
//

import Foundation

final class MovieDetailRepository: MovieDetailRepositoryInterface {

    private let firebaseService = FirebaseService.shared

    func fetchMovieDetail(movieCode: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
    }

    func fetchMovieReview(movieCode: String, completion: @escaping (Result<[MovieReview], Error>) -> Void) {
        firebaseService.fetchMovieReviews(of: movieCode) { result in
            switch result {
            case .success(let movieReviewDTOs):
                let movieReviews = movieReviewDTOs.map {
                    $0.toDomain()
                }
                completion(.success(movieReviews))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }

    func deleteMovieReview(review: MovieReview, completion: @escaping (Result<Void, Error>) -> Void) {
    }
}
