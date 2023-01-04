//
//  APIService.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

final class APIService {
    
    let repository = Repository()
    
    typealias PosterResult = Result<MovieEntity, Error>
    typealias BoxOfficeResult = Result<BoxOfficeEntity, Error>
    typealias MovieInfoResult = Result<MovieInfoEntity, Error>
    
    func fetchPoster(title: String, completion: @escaping (PosterResult) -> Void) {
        repository.fetchPoster(title: title) { result in
            switch result {
            case let .success(data):
                guard let moviePoster = self.parseJson(from: data, to: MovieEntity.self) else { return }
                completion(.success(moviePoster))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchBoxOffice(date: String, completion: @escaping (BoxOfficeResult) -> Void) {
        repository.fetchBoxOffice(date: date) { result in
            switch result {
            case let .success(data):
                guard let movieList = self.parseJson(from: data, to: BoxOfficeEntity.self) else { return }
                completion(.success(movieList))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieDetail(movieCd: String, completion: @escaping (MovieInfoResult) -> Void) {
        repository.fetchMovieDetail(movieCd: movieCd) { result in
            switch result {
            case let .success(data):
                guard let movieDetail = self.parseJson(from: data, to: MovieInfoEntity.self) else { return }
                completion(.success(movieDetail))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func parseJson<T: Decodable>(from data: Data, to type: T.Type) -> T? {
        do {
            let decodeData = try JSONDecoder().decode(type, from: data)
            return decodeData
        } catch {
            print("디코딩 실패")
            print(error.localizedDescription)
            return nil
        }
    }
}
