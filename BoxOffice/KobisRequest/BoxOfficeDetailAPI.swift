//
//  BoxOfficeRequest.swift
//  BoxOffice
//
//  Created by 백곰 on 2023/01/04.
//

import Foundation

class BoxOfficeDetailAPI {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared){
        self.session = session
    }
    
    func dataTask(by selectMovie: String, completion: @escaping (Result<MovieDetailInfo, Error>) -> ()) {
        let exampleURL = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=e654b63663c57dea1f3ed2abb4fae5d2&movieCd=\(selectMovie)"
        guard let url = URL(string: exampleURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return completion(.failure(CustomError.statusCodeError))
            }
            
            if let data = data {
                do {
                    let decodeData = try JSONDecoder().decode(MovieDetailInfo.self, from: data)
                    completion(.success(decodeData))
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}

protocol URLSessionProtocol {
    func dataTask(with request: URLRequest,completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol { }
