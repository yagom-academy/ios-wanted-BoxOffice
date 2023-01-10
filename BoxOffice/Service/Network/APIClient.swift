//
//  APIClient.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/02.
//

import Foundation

struct APIClient {
    static let shared = APIClient(sesseion: URLSession.shared)
    private let session: URLSession
    
    func requestData(with urlRequest: URLRequest) async throws -> Data {
        let (data, response) = try await session.data(for: urlRequest)
        let successRange = 200..<300
        if let statusCode = (response as? HTTPURLResponse)?.statusCode,
           !successRange.contains(statusCode) {
            
        }
        return data
    }

    init(sesseion: URLSession) {
        self.session = sesseion
    }
}
