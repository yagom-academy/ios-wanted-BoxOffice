//
//  APIRequestLoader.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/19.
//

import Foundation
import Combine


final class APIRequestLoader {

    private let session: URLSession

    init(session: URLSession = .shared) {
        self.session = session
    }

    func execute(_ request: any RequestType) async throws -> Data {
        let request = try request.makeRequest()
        let (data, response) = try await session.data(for: request)
        try validateResponse(response)
        return data
    }

    private func validateResponse(_ response: URLResponse) throws {
        guard let httpResponse = response as? HTTPURLResponse,
              (200..<300).contains(httpResponse.statusCode) else {
            throw NetworkError.badServerResponse
        }
    }

}

enum NetworkError: Error, LocalizedError {
    
    case createURLRequestFailed
    case badServerResponse

}
