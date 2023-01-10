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
    func execute(using client: APIClient = APIClient.shared) async throws -> ResponseType? {
        guard let urlRequest = configuration.makeURLRequest() else { return nil }
        let data = try await client.requestData(with: urlRequest)
        let result = try JSONDecoder().decode(ResponseType.self, from: data)
        return result
    }
}
