//
//  HTTPClient.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import Foundation

enum HTTPMethod: String {
    case GET, POST, PUT, PATCH, DELETE
}

enum MINEType: String {
    case JSON = "application/json"
}

enum HTTPHeaders: String {
    case contentType = "Content-Type"
}

enum HTTPError: Error {
    case badURL, badResponse, errorDecodingData, invalidURL, iosDevloperIsStupid
}

protocol HTTPClientProtocol {
    func fetch<T: Codable>(api: API) async throws -> T
}

class HTTPClient: HTTPClientProtocol {
    
    func fetch<T: Codable>(api: API) async throws -> T {
        let baseComponent = api.urlComponets
        let httpMethod = api.httpMethod.rawValue
        
        guard let url = baseComponent?.url else { throw HTTPError.badURL }
        var request = URLRequest(url: url)
        request.httpMethod = httpMethod
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HTTPError.badResponse
        }
        
        guard let object = try? JSONDecoder().decode(T.self, from: data) else {
            throw HTTPError.errorDecodingData
        }
        return object
    }
}
