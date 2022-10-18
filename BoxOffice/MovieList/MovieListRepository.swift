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

protocol MovieListReqeustable: AnyObject {
    func fetchMovieList(targetDate: String, completion: @escaping(Result<MovieEntity, NetworkError>) -> ())
}

final class MovieListRepository: MovieListReqeustable{
    
    private let apiKey: String = "cd29056014ff4d3d61f1a01bca97dfdb"
    
    func fetchMovieList(targetDate: String, completion: @escaping (Result<MovieEntity, NetworkError>) -> ()) {
        guard let url = makeMovieListComponents(targetDate: targetDate).url else {
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
                let movieEntity = try JSONDecoder().decode(MovieEntity.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(movieEntity))
                }
            } catch {
                completion(.failure(.decodingFail))
            }
        }
        
        dataTask.resume()
    }
    
}

private extension MovieListRepository {
    
    struct MovieListAPI {
        enum MovieType: String {
            case daily = "Daily"
            case weekly = "Weekly"
        }
        static let scheme = "https"
        static let host = "www.kobis.or.kr"
        static let movieType: MovieType = .daily
        static let path = "/kobisopenapi/webservice/rest/boxoffice/search\(movieType.rawValue)BoxOfficeList.json"
    }
    
    func makeMovieListComponents(targetDate: String) -> URLComponents {
        var components = URLComponents()
        components.scheme = MovieListAPI.scheme
        components.host = MovieListAPI.host
        components.path = MovieListAPI.path
        components.queryItems = [
            URLQueryItem(name: "targetDt", value: "\(targetDate)"),
            URLQueryItem(name: "korNm", value: "Seoul"),
            URLQueryItem(name: "key", value: apiKey)
        ]
        return components
    }
}
