//
//  MovieSearchService.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/17.
//

import Foundation

protocol MovieSearchAPI {

    func searchMovieRanking(for duration: DurationUnit) async throws -> [MovieRanking]
    func searchMovieDetail(for identifier: String) async throws -> MovieDetail

}

class MovieSearchService: MovieSearchAPI {

    private let apiRequestLoader: APIRequestLoader

    init(apiRequestLoader: APIRequestLoader = .init()) {
        self.apiRequestLoader = apiRequestLoader
    }

    func searchMovieRanking(for duration: DurationUnit) async throws -> [MovieRanking] {
        let request = MovieRankingRequest.value(atDate: Date().addingTimeInterval(-60 * 60 * 24), forDuration: duration)
        let data = try await apiRequestLoader.execute(request)
        let result = try request.parseResponse(data: data)
        return result.rankingList
    }

    func searchMovieDetail(for identifier: String) async throws -> MovieDetail {
        let request = MovieDetailRequest.value(forIdentifier: identifier)
        let data = try await apiRequestLoader.execute(request)
        let result = try request.parseResponse(data: data)
        return result
    }
    
}


