//
//  MovieListRepository.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/18.
//

import UIKit

enum NetworkError: Error {
    case noURL
    case unknownError
    case serverError(_ statusCode: Int)
    case noData
    case decodingFail
}

protocol MovieReqeustable: AnyObject {
    func fetchMovieList(targetDate: String, completion: @escaping(Result<MovieListEntity, NetworkError>) -> ())
    func fetchMovieDetail(movieCode: String, completion: @escaping(Result<MovieDetailEntity, NetworkError>) -> ())
}

final class MovieRepository: MovieReqeustable {
    
    private let apiKey: String = "cd29056014ff4d3d61f1a01bca97dfdb"
    
    func fetchMovieList(targetDate: String, completion: @escaping (Result<MovieListEntity, NetworkError>) -> ()) {
        guard let url = makeListComponents(targetDate: targetDate).url else {
            completion(.failure(.noURL))
            return
        }
        
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknownError))
                return
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.serverError(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else{
                completion(.failure(.noData))
                return
            }
            
            do {
                let movieEntity = try JSONDecoder().decode(MovieListEntity.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(movieEntity))
                }
            } catch {
                completion(.failure(.decodingFail))
            }
        }
        
        dataTask.resume()
    }
    
    func fetchMovieDetail(movieCode: String, completion: @escaping (Result<MovieDetailEntity, NetworkError>) -> ()) {
        guard let url = makeDetailComponents(movieCode: movieCode).url else {
            completion(.failure(.noURL))
            return
        }
        print("url \(url)")
        let dataTask = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.unknownError))
                return
            }
            
            guard 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.serverError(httpResponse.statusCode)))
                return
            }
            
            guard let data = data else{
                completion(.failure(.noData))
                return
            }
            
            do {
                let entity = try JSONDecoder().decode(MovieDetailEntity.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(entity))
                }
            } catch {
                completion(.failure(.decodingFail))
            }
        }
        dataTask.resume()
    }
    
}

private extension MovieRepository {
    
    struct MovieAPI {
        static let scheme = "https"
        static let host = "www.kobis.or.kr"
    }
    
    struct MovieListAPI {
        enum MovieType: String {
            case daily = "Daily"
            case weekly = "Weekly"
        }
        static let movieType: MovieType = .daily
        static let path = "/kobisopenapi/webservice/rest/boxoffice/search\(movieType.rawValue)BoxOfficeList.json"
    }
    
    struct MovieDetailAPI {
        static let path = "/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    }
    
    private func makeListComponents(targetDate: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = MovieAPI.scheme
        components.host = MovieAPI.host
        components.path = MovieListAPI.path
        components.queryItems = [
            URLQueryItem(name: "targetDt", value: "\(targetDate)"),
            URLQueryItem(name: "korNm", value: "Seoul"),
            URLQueryItem(name: "key", value: apiKey)
        ]
        return components
    }
    
    private func makeDetailComponents(movieCode: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = MovieAPI.scheme
        components.host = MovieAPI.host
        components.path = MovieDetailAPI.path
        components.queryItems = [
            URLQueryItem(name: "key", value: apiKey),
            URLQueryItem(name: "movieCd", value: "\(movieCode)")
        ]
        return components
    }
}
