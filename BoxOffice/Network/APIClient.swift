//
//  APIClient.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/02.
//

import Foundation

struct APIClient {
    typealias CompletionHandler = (Result<Data, Error>) -> Void
    static let shared = APIClient(sesseion: URLSession.shared)
    private let session: URLSession
    
    func requestData(with urlRequest: URLRequest,
                     completionHandler: @escaping CompletionHandler) {
        session.dataTask(with: urlRequest) { (data, response, error) in
            let successRange = 200..<300
            if let statusCode = (response as? HTTPURLResponse)?.statusCode,
            !successRange.contains(statusCode) {
                completionHandler(.failure(APIError.response(statusCode)))
                return
            }
            guard let data = data else {
                completionHandler(.failure(error ?? APIError.unknown))
                return
            }
            completionHandler(.success(data))
        }.resume()
    }
    
    func requestData(with url: URL,
                     completionHandler: @escaping CompletionHandler) {
        session.dataTask(with: url) { (data, _, error)  in
            guard let data = data else {
                DispatchQueue.main.async {
                    completionHandler(.failure(error ?? APIError.unknown))
                }
                return
            }
            DispatchQueue.main.async {
                completionHandler(.success(data))
            }
        }.resume()
    }
    
    init(sesseion: URLSession) {
        self.session = sesseion
    }
}
