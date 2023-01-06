//
//  Repository.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

final class Repository {
    
    private let firstApiKey = "325ca562"
    private let secondApiKey = ""
    
    private let boxOfficeApiKey = "42067899a1fd583566eb123ec528802d"
    
    private let omdbAPIUrl = "https://www.omdbapi.com/"
    private let posterUrl = "https://img.omdbapi.com/"
    
    private let boxOfficeUrl = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json"
    private let moviewDetail = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json"
    
    typealias FetchResult = Result<Data, Error>

    func fetchBoxOffice(date: String, completion: @escaping (FetchResult) -> Void) {
        var urlComponent = URLComponents(string: boxOfficeUrl)
        urlComponent?.queryItems = [
            URLQueryItem(name: "key", value: boxOfficeApiKey),
            URLQueryItem(name: "targetDt", value: date),
            URLQueryItem(name: "wideAreaCd", value: "0105001")
        ]
        
        guard let url = urlComponent?.url else { return }
        
        fetch(url) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchMovieDetail(movieCd: String, completion: @escaping (FetchResult) -> Void) {
        var urlComponent = URLComponents(string: moviewDetail)
        urlComponent?.queryItems = [
            URLQueryItem(name: "key", value: boxOfficeApiKey),
            URLQueryItem(name: "movieCd", value: movieCd),
        ]
        
        guard let url = urlComponent?.url else { return }
        
        fetch(url) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func fetchPoster(title: String, completion: @escaping (FetchResult) -> Void) {
        var urlComponent = URLComponents(string: omdbAPIUrl)
        urlComponent?.queryItems = [
            URLQueryItem(name: "apikey", value: firstApiKey),
            URLQueryItem(name: "t", value: title)
        ]
        
        guard let url = urlComponent?.url else { return }
        
        fetch(url) { result in
            switch result {
            case .success(let data):
                completion(.success(data))
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    private func fetch(_ url: URL, _ completion: @escaping (FetchResult) -> Void) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "네트워킹 실패", code: -1)))
                return
            }
            print("\(#function), \(response.statusCode)")
            
            guard let data = data else { return }
            completion(.success(data))
        }.resume()
    }
}
