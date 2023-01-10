//
//  MockSession.swift
//  BoxOfficeTests
//
//  Created by bard on 2023/01/02.
//

import Foundation
@testable import BoxOffice

struct MockSession: APIService {
    let url: String
    let fileExtension: String
    
    init(url: String, fileExtension: String) {
        self.url = url
        self.fileExtension = fileExtension
    }
    
    func execute<T: APIRequest>(
        _ request: T,
        completion: @escaping (Result<T.APIResponse, APIError>) -> Void
    ) {
        guard let data = loadMockData(url: url, fileExtension: fileExtension) else {
            completion(.failure(.failedToParse))
            return
        }
        
        guard let jsonData = try? JSONDecoder().decode(
            DailyBoxOfficeResponse.self,
            from: data
        ) as? T.APIResponse else {
            completion(.failure(.failedToParse))
            return
        }

        completion(.success(jsonData))
    }
}
