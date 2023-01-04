//
//  MockCenter.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/02.
//

import Foundation

final class MockMovieListRepository: MovieListRepositoryInterface {
    func fetchMovieList(page: Int, dayType: DayType, completion: @escaping (Result<[MovieOverview], Error>) -> Void) {
        let movieOverviewList = [
            MovieOverview(movieCode: "1", dayType: .weekdays, region: .Seoul, rank: 1, title: "임시 TITLE 1", openingDay: Date(), audienceNumber: 10000, rankFluctuation: 3, isNewlyRanked: true),
            MovieOverview(movieCode: "2", dayType: .weekdays, region: .Seoul, rank: 2, title: "임시 TITLE 2", openingDay: Date(), audienceNumber: 1000, rankFluctuation: -1, isNewlyRanked: false),
            MovieOverview(movieCode: "3", dayType: .weekdays, region: .Seoul, rank: 3, title: "임시 TITLE 3", openingDay: Date(), audienceNumber: 100, rankFluctuation: 0, isNewlyRanked: false),
            MovieOverview(movieCode: "4", dayType: .weekdays, region: .Seoul, rank: 4, title: "임시 TITLE 4", openingDay: Date(), audienceNumber: 100, rankFluctuation: 5, isNewlyRanked: true),
            MovieOverview(movieCode: "5", dayType: .weekdays, region: .Seoul, rank: 5, title: "임시 TITLE 5", openingDay: Date(), audienceNumber: 100, rankFluctuation: 5, isNewlyRanked: false)
        ]
        
        completion(.success(movieOverviewList))
    }
}

final class MockMovieDetailRepository: MovieDetailRepositoryInterface {
    func fetchMovieDetail(of movieCode: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        
    }
}
