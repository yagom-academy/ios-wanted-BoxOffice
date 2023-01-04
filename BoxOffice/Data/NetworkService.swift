//
//  NetworkService.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/03.
//

import Foundation

final class NetworkService {
    static let shared = NetworkService()
    
    private init() { }
    
    func dataTask(request: URLRequest, completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if error != nil {
                completion(.failure(error!))
                return
            }
            
            guard self.isValidResponse(response) else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data else {
                completion(.failure(error!))
                return
            }
            
            completion(.success(data))
        }
        
        return task
    }
    
    private func isValidResponse(_ response: URLResponse?) -> Bool {
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
            return false
        }
        
        return true
    }
}
