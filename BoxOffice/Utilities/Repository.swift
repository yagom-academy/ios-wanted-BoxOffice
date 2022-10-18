//
//  Repository.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import Foundation

protocol RepositoryProtocol {
    var httpClient: HTTPClientProtocol { get set }
    func fetch<T: Codable>(api: API) async throws -> T
}

class Repository: RepositoryProtocol {
    
    var httpClient: HTTPClientProtocol
    
    init(httpClient: HTTPClientProtocol) {
        self.httpClient = httpClient
    }
    
    func fetch<T: Codable>(api: API) async throws -> T {
        let result: T = try await httpClient.fetch(api: api)
        return result
    }
}
