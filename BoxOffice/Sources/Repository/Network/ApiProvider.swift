//
//  ApiProvider.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/18.
//

import Foundation
import Combine

protocol ApiProviderProtocol {
    func request(_ target: TargetType, useCaching: Bool) -> AnyPublisher<(data: Data, response: URLResponse), URLError>
}

class ApiProvider: ApiProviderProtocol {
    // MARK: Singleton
    static let shared = ApiProvider()
    
    private init() { }
    
    func request(_ target: TargetType, useCaching: Bool = false) -> AnyPublisher<(data: Data, response: URLResponse), URLError> {
        guard let request = target.request
        else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        Logger.logRequest(request, target: target)
        
        if useCaching,
           let cached = URLCache.shared.cachedResponse(for: request) {
            print("💶💶💶Cached Response Returned💶💶💶")
            Logger.logResponse((data: cached.data, response: cached.response), target: target)
            return Just((data: cached.data, response: cached.response))
                .setFailureType(to: URLError.self)
                .eraseToAnyPublisher()
        }
        print("💶💶💶New Request Created💶💶💶")
        return URLSession.shared.dataTaskPublisher(for: request)
            .handleEvents(receiveOutput: { data, response in
                URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)
                Logger.logResponse((data: data, response: response), target: target)
            }).eraseToAnyPublisher()
    }
}
