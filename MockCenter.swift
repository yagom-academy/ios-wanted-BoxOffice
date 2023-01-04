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
    func uploadReview(review: MovieReview, completion: @escaping (Result<Void, Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
            completion(.success(()))
        }
    }
}

var dummyMovieOverview: MovieOverview {
    return MovieOverview(movieCode: "", dayType: .weekdays, region: .Seoul, rank: 1, title: "아바타", openingDay: Date(), audienceNumber: 200, rankFluctuation: 1, isNewlyRanked: true)
}

var dummyMovieDetail: MovieDetail {
    return MovieDetail(movieCode: UUID().description, rank: 1, title: "아바타", openingDay: Date(), audienceNumber: 10000, rankFluctuation: 1, isNewlyRanked: true, productionYear: 2023, playTime: 123.5, genre: "SF", directorsName: "봉준호", actorsName: "이병헌", watchGrade: 13, posterImage: dummyPosterImage, posterImageURL: "https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_SX300.jpg") }

var dummyMovieDetails: [MovieDetail] = Array.init(repeating: MovieDetail(movieCode: UUID().description, rank: 1, title: "아바타", openingDay: Date(), audienceNumber: 10000, rankFluctuation: 1, isNewlyRanked: true, productionYear: 2023, playTime: 123.5, genre: "SF", directorsName: "봉준호", actorsName: "이병헌", watchGrade: 13, posterImage: dummyPosterImage, posterImageURL: "https://m.media-amazon.com/images/M/MV5BYjhiNjBlODctY2ZiOC00YjVlLWFlNzAtNTVhNzM1YjI1NzMxXkEyXkFqcGdeQXVyMjQxNTE1MDA@._V1_SX300.jpg"), count: 10)

var dummyMovieReview: MovieReview {
    return MovieReview(id: UUID(), movieCode: "", user: User(nickname: "Neph"), password: "1234", rating: 5, image: "", description: "와 정말 재밌어요")
}

let dummyPosterImage = UIImage(named: "dummyPosterImage")
