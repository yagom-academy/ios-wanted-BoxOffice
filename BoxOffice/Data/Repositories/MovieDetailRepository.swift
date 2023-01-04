//
//  MovieDetailRepository.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/04.
//

import Foundation

final class MovieDetailRepository: MovieDetailRepositoryInterface {

    private let firebaseService = FirebaseService.shared
    private let neworkService = NetworkService.shared

    func fetchMovieDetail(movieCode: String, completion: @escaping (Result<MovieDetail, Error>) -> Void) {
        var urlComponents = URLComponents(string: "https://www.kobis.or.kr")
        urlComponents?.path = "/kobisopenapi/webservice/rest/movie/searchMovieInfo"
        urlComponents?.queryItems = [
            .init(name: "key", value: neworkService.koficAPIKey),
            .init(name: "movieCd", value: movieCode)
        ]
        guard let url = urlComponents?.url else { return }
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
                break
            case .failure(let error):
                completion(.failure(error))
            }
        }

        task.resume()
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

// MARK: - Private Functions
extension MovieDetailRepository {

}
