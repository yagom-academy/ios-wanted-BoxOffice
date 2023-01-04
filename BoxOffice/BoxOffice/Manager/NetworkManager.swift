//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by 유한석 on 2023/01/03.
//

import Foundation

enum NetWorkError: Error {
    case networkError
}

final class NetworkManager {
    func executeDataTask(request: APIRequest, completion: @escaping (Result<Data, NetWorkError>) -> Void) {
        guard let request = request.urlRequest else {
            completion(.failure(NetWorkError.networkError))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard error == nil else {
                completion(.failure(NetWorkError.networkError))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 <= response.statusCode, response.statusCode < 300
            else {
                completion(.failure(NetWorkError.networkError))
                return
            }
            
            guard let safeData = data else {
                completion(.failure(NetWorkError.networkError))
                return
            }
            
            completion(.success(safeData))
            
        }
        task.resume()
    }
}
