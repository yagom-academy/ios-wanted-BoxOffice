//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by dhoney96 on 2023/01/02.
//

import Foundation

class NetworkManager {
    private let session: URLSession
    
    init(session: URLSession = URLSession.shared) {
        self.session = session
    }
    
    func dataTask(api: APIRequest, completion: @escaping (Result<Data?, Error>) -> Void) {
        guard let request = api.configureRequest() else {
            return
        }
        
        self.session.dataTask(with: request) { data, response, error in
            guard error == nil else {
                return completion(.failure(error!))
            }

            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return completion(.failure(error!))
            }

            guard let data = data else {
                return completion(.failure(error!))
            }

            completion(.success(data))
        }.resume()
    }
}
