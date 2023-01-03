//
//  DefaultAPIProvider.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation
import Combine

final class DefaultAPIProvider: APIProvider {
    
    let session: URLSession
    let cache: URLCache
    
    init(session: URLSession = .shared, cache: URLCache = .shared) {
        self.session = session
        self.cache = cache
    }
    
    func excute(_ target: TargetType, useCaching: Bool) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        guard let urlRequest = target.request else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        if useCaching, let cached = cache.cachedResponse(for: urlRequest) {
            return Just((data: cached.data, response: cached.response))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        return session.dataTaskPublisher(for: urlRequest)
            .handleEvents(receiveOutput: { [weak self] data, response in
            self?.cache.storeCachedResponse(CachedURLResponse(response: response, data: data), for: urlRequest)
        }).mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
}
