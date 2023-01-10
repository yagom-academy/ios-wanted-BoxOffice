//
//  APIService.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

import UIKit.UIImage

protocol APIService {
    func execute<T: APIRequest>(
        _ request: T,
        completion: @escaping (Result<T.APIResponse, APIError>) -> Void
    )
}

extension APIService {
    func parse<T: Decodable>(_ response: Data) -> T? {
        let parsedData = try? JSONDecoder().decode(T.self, from: response)
        
        return parsedData
    }
    
    func parse(_ response: Data) -> CodableImage? {
        guard let parsedData = UIImage(data: response) else {
            return nil
        }

        return CodableImage(image: parsedData)
    }
}
