//
//  MovieDetailRepository.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/04.
//

import UIKit

final class MovieDetailRepository: MovieDetailRepositoryInterface {

    private let firebaseService = FirebaseService.shared
    private let neworkService = NetworkService.shared

    func fetchMovieDetail(movieCode: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) -> Cancellable? {
        var urlComponents = URLComponents(string: "https://www.kobis.or.kr")
        urlComponents?.path = "/kobisopenapi/webservice/rest/movie/searchMovieInfo"
        urlComponents?.queryItems = [
            .init(name: "key", value: neworkService.koficAPIKey),
            .init(name: "movieCd", value: movieCode)
        ]
        guard let url = urlComponents?.url else { return nil }
        let urlRequest = URLRequest(url: url)
        let task = neworkService.dataTask(request: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let movieDetailResponseDTO = try JSONDecoder().decode(MovieDetailResponseDTO.self, from: data)
                    completion(.success(movieDetailResponseDTO.movieInfoResult.movieInfo.toDomain()))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }

        return task
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
        firebaseService.deleteReview(id: review.id.uuidString) { result in
            completion(result)
        }
    }

    func fetchMoviePoster(englishMovieName: String, year: String, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable? {
        var urlString = ""
        let task = fetchMoviePosterURL(englishMovieName: englishMovieName, year: year) { result in
            switch result {
            case .success(let result):
                urlString = result
                guard let url = URL(string: urlString) else { return }

                let task = self.neworkService.dataTask(request: URLRequest(url: url)) { result in
                    switch result {
                    case .success(let data):
                        completion(.success(UIImage(data: data)))
                    case .failure(let error):
                        completion(.failure(error))
                    }
                }
                task?.resume()
            case .failure:
                return
            }
        }

        return task
    }

    func fetchReviewImage(imageURL: String, completion: @escaping (Result<UIImage?, Error>) -> Void) -> Cancellable? {
        let task = firebaseService.fetchReviewImage(imageURL: imageURL) { result in
            completion(result)
        }
        return task
    }
}

// MARK: - Private Functions
extension MovieDetailRepository {
    private func fetchMoviePosterURL(englishMovieName: String, year: String, completion: @escaping (Result<String, Error>) -> Void) -> Cancellable? {
        var urlComponents = URLComponents(string: "http://www.omdbapi.com/")
        urlComponents?.queryItems = [
            .init(name: "apikey", value: neworkService.omdbAPIKey),
            .init(name: "t", value: englishMovieName),
            .init(name: "y", value: String(year))
        ]
        guard let url = urlComponents?.url else {
            return nil

        }
        let urlRequest = URLRequest(url: url)
        let task = neworkService.dataTask(request: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let posterDTO = try JSONDecoder().decode(PosterDTO.self, from: data)
                    completion(.success(posterDTO.posterURL))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        return task
    }
}
