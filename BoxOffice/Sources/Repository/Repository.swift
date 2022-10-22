//
//  Repository.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/18.
//

import Foundation
import Combine
import UIKit
import FirebaseStorage

protocol RepositoryProtocol {
    
}

class Repository {
    let apiProvider: ApiProviderProtocol
    
    init(apiProvider: ApiProviderProtocol = ApiProvider.shared) {
        self.apiProvider = apiProvider
    }
    
    func dailyBoxOffice(_ targetDt: String) -> AnyPublisher<[Movie], Error> {
        let param = BoxOfficeListRequest(key: Environment.kobisKey, targetDt: targetDt)
        return apiProvider.request(KobisAPI.dailyBoxOfficeList(param), useCaching: true)
            .subscribe(on: DispatchQueue.global())
            .map { $0.data }
            .decode(type: DailyBoxOfficeListResponse.self, decoder: JSONDecoder())
            .map { Translator.translate($0) }
            .eraseToAnyPublisher()
    }
    
    func weeklyBoxOffice(_ targetDt: String, weekGb: BoxOfficeListRequest.WeekGubun) -> AnyPublisher<[Movie], Error> {
        let param = BoxOfficeListRequest(key: Environment.kobisKey, targetDt: targetDt, weekGb: weekGb)
        return apiProvider.request(KobisAPI.weeklyBoxOfficeList(param), useCaching: true)
            .subscribe(on: DispatchQueue.global())
            .map { $0.data }
            .decode(type: WeeklyBoxOfficeListResponse.self, decoder: JSONDecoder())
            .map { Translator.translate($0) }
            .eraseToAnyPublisher()
    }
    
    func movieDetail(_ movieCd: String) -> AnyPublisher<MovieDetailInfo, Error> {
        let param = MovieDetailRequest(key: Environment.kobisKey, movieCd: movieCd)
        return apiProvider.request(KobisAPI.movieDetail(param), useCaching: true)
            .subscribe(on: DispatchQueue.global())
            .map(\.data)
            .decode(type: MovieDetailResponse.self, decoder: JSONDecoder())
            .tryMap { try Translator.translate($0) }
            .eraseToAnyPublisher()
    }
    
    func moviePoster(_ movieNameEnglish: String) -> AnyPublisher<String, Error> {
        let param = MoviePosterRequest(apikey: Environment.omdbKey, t: movieNameEnglish)
        return apiProvider.request(OmdbAPI.moviePoster(param), useCaching: true)
            .subscribe(on: DispatchQueue.global())
            .map(\.data)
            .decode(type: MoviePosterResponse.self, decoder: JSONDecoder())
            .tryMap { try Translator.translate($0) }
            .eraseToAnyPublisher()
    }
    
    func getMovieReviews(_ movieCode: String) -> AnyPublisher<[Review], Error> {
        return Storage.storage().reference().child("\(movieCode)")
            .getData(maxSize: 1024 * 1024 * 20)
            .subscribe(on: DispatchQueue.global())
            .decode(type: [Review].self, decoder: JSONDecoder())
            .eraseToAnyPublisher()
    }
    
    func putMovieReviews(_ movieCode: String, review: Review) -> AnyPublisher<StorageMetadata, Error> {
        return Storage.storage().reference().child("\(movieCode)")
            .getData(maxSize: 1024 * 1024 * 20)
            .subscribe(on: DispatchQueue.global())
            .decode(type: [Review].self, decoder: JSONDecoder())
            .catch { _ in
                return Just([Review]())
            }.map { reviews in
                var reviews = reviews
                reviews.append(review)
                return reviews
            }.encode(encoder: JSONEncoder())
            .flatMap { data in
                return Storage.storage().reference().child("\(movieCode)").putData(data)
            }.eraseToAnyPublisher()
    }
    
    func deleteMovieReview(_ movieCode: String, review: Review) -> AnyPublisher<StorageMetadata, Error> {
        return Storage.storage().reference().child("\(movieCode)")
            .getData(maxSize: 1024 * 1024 * 20)
            .subscribe(on: DispatchQueue.global())
            .decode(type: [Review].self, decoder: JSONDecoder())
            .catch { _ in
                return Just([Review]())
            }.map { reviews in
                var reviews = reviews
                reviews.removeAll(where: { $0 == review })
                return reviews
            }.encode(encoder: JSONEncoder())
            .flatMap { data in
                return Storage.storage().reference().child("\(movieCode)").putData(data)
            }.eraseToAnyPublisher()
    }
    
    func loadImage(_ url: String) -> AnyPublisher<UIImage, Error> {
        return apiProvider.request(image: url)
    }
}
