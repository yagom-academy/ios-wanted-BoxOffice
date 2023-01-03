//
//  API.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/02.
//

import Foundation

protocol API {
    associatedtype ResponseType: Decodable
    var configuration: APIConfiguration { get }
}

extension API {
    typealias CompletionHandler = (Result<ResponseType, Error>) -> Void
    
    func execute(using client: APIClient = APIClient.shared,
                 _ completionHandler: @escaping CompletionHandler) {
        guard let urlRequest = configuration.makeURLRequest() else { return }
        client.requestData(with: urlRequest) { (result) in
            switch result {
            case .success(let data):
                do {
                    let result = try JSONDecoder().decode(ResponseType.self, from: data)
                    completionHandler(.success(result))
                } catch {
                    completionHandler(.failure(error))
                }
            case .failure(let error):
                completionHandler(.failure(error))
            }
        }
    }
}
