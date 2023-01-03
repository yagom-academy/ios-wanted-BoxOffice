//
//  DefaultBoxOfficeRepository.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation
import Combine

final class DefaultBoxOfficeRepository: BoxOfficeRepository {
    
    let apiProvider: APIProvider
    let decoder: JSONDecoder
    
    init(apiProvider: APIProvider = DefaultAPIProvider(), decoder: JSONDecoder = .init()) {
        self.apiProvider = apiProvider
        self.decoder = decoder
    }
    
    func dailyBoxOffice(date targetDt: Date) -> AnyPublisher<[Movie], Error> {
        let param = BoxOfficeListRequest(
            key: Bundle.main.kobisApiKey ?? "",
            targetDt: targetDt.toString(.yyyyMMdd)
        )
        return apiProvider.excute(KobisAPI.dailyBoxOfficeList(param), useCaching: true)
            .subscribe(on: DispatchQueue.global())
            .map(\.data)
            .decode(type: DailyBoxOfficeListResponse.self, decoder: decoder)
            .map { $0.toMovies() }
            .eraseToAnyPublisher()
    }
    
    func weeklyBoxOffice(date targetDt: Date, weekGb: BoxOfficeListRequest.WeekGubun) -> AnyPublisher<[Movie], Error> {
        let param = BoxOfficeListRequest(
            key: Bundle.main.kobisApiKey ?? "",
            targetDt: targetDt.toString(.yyyyMMdd),
            weekGb: weekGb
        )
        return apiProvider.excute(KobisAPI.weeklyBoxOfficeList(param), useCaching: true)
            .subscribe(on: DispatchQueue.global())
            .map(\.data)
            .decode(type: DailyBoxOfficeListResponse.self, decoder: decoder)
            .map { $0.toMovies() }
            .eraseToAnyPublisher()
    }
    
    func movieInfo(code movieCd: String) -> AnyPublisher<MovieDetailInfo, Error> {
        let param = MovieRequest(
            key: Bundle.main.kobisApiKey ?? "",
            movieCd: movieCd
        )
        return apiProvider.excute(KobisAPI.movieInfo(param), useCaching: true)
            .subscribe(on: DispatchQueue.global())
            .map(\.data)
            .decode(type: MovieInfoResponse.self, decoder: decoder)
            .map { $0.toMovieDetailInfo() }
            .eraseToAnyPublisher()
    }
    
    func moviePoster(name movieNameEnglish: String) -> AnyPublisher<String, Error> {
        let param = MoviePosterRequest(
            apiKey: Bundle.main.omdbApiKey ?? "",
            t: movieNameEnglish
        )
        return apiProvider.excute(OmdbAPI.moviePoster(param), useCaching: true)
            .subscribe(on: DispatchQueue.global())
            .map(\.data)
            .decode(type: MoviePosterResponse.self, decoder: decoder)
            .compactMap { $0.poster }
            .eraseToAnyPublisher()
    }
    
}
