//
//  MockCenter.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/02.
//

import UIKit

final class MockMovieListRepository: MovieListRepositoryInterface {
    func fetchMovieList(page: Int, dayType: DayType, completion: @escaping (Result<[MovieOverview], Error>) -> Void) {
        let overviews = Array.init(repeating: dummyMovieOverview, count: 20)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(overviews))
        }
    }
}

final class MockMovieDetailRepository: MovieDetailRepositoryInterface {
    func fetchReviewImage(imageURL: String, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable? {
        return nil
    }

    func fetchMoviePoster(englishMovieName: String, completion: @escaping (Result<UIImage?, Error>) -> Void) {

    }

    func fetchMovieDetail(movieCode: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(dummyMovieDetail))
        }
    }

    func fetchMovieReview(movieCode: String, completion: @escaping (Result<[MovieReview], Error>) -> Void) {
        var reviews = [MovieReview]()
        reviews.append(MovieReview(id: UUID(), movieCode: "", user: User(nickname: "Neph"), password: "1234", rating: 5, image: "", description: "와 정말 재밌어요 길어요 길어요 와 정말 재밌어요 길어요 길어요와 정말 재밌어요 길어요 길어요"))
        for _ in 0..<20 {
            reviews.append(MovieReview(id: UUID(), movieCode: "", user: User(nickname: "Neph"), password: "1234", rating: 5, image: "", description: "와 정말 재밌어요"))
        }

        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(reviews))
        }
    }

    func deleteMovieReview(review: MovieReview, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(()))
        }
    }
}

final class MockReviewWritingRepository: ReviewWritingRepositoryInterface {
    func uploadReview(image: UIImage, review: MovieReview, completion: @escaping (Result<Void, Error>) -> Void) {

    }
}

var dummyMovieOverview: MovieOverview {
    return MovieOverview(movieCode: "", dayType: .weekdays, region: .Seoul, rank: 1, title: "아바타", openingDay: Date(), audienceNumber: 200, rankFluctuation: 1, isNewlyRanked: true)
}

var dummyMovieDetail: MovieDetail {
    return MovieDetail(movieCode: "", title: "", englishTitle: "", productionYear: 0, playTime: 0, genre: "", directorsName: "", actorsName: "", watchGrade: "") }

var dummyMovieDetails: [MovieDetail] = []

var dummyMovieReview: MovieReview {
    return MovieReview(id: UUID(), movieCode: "", user: User(nickname: "Neph"), password: "1234", rating: 5, image: "", description: "와 정말 재밌어요")
}

let dummyPosterImage = UIImage(named: "dummyPosterImage")
