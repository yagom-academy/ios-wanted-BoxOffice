//
//  ApiProvider.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/18.
//

import Foundation
import Combine
import UIKit

protocol ApiProviderProtocol {
    func request(_ target: TargetType, useCaching: Bool) -> AnyPublisher<(data: Data, response: URLResponse), Error>
    func request(image url: String) -> AnyPublisher<UIImage, Error>
}

class ApiProvider: ApiProviderProtocol {
    // MARK: Singleton
    static let shared = ApiProvider()
    
    private init() { }
    
    func request(_ target: TargetType, useCaching: Bool = false) -> AnyPublisher<(data: Data, response: URLResponse), Error> {
        guard let request = target.request
        else {
            return Fail(error: URLError(.badURL)).eraseToAnyPublisher()
        }
        Logger.logRequest(request)
        
        if useCaching,
           let cached = URLCache.shared.cachedResponse(for: request) {
            print("💶💶💶Cached Response Returned💶💶💶")
            Logger.logResponse((data: cached.data, response: cached.response))
            return Just((data: cached.data, response: cached.response))
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        print("💶💶💶New Request Created💶💶💶")
        return URLSession.shared.dataTaskPublisher(for: request)
            .handleEvents(receiveOutput: { data, response in
                URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: data), for: request)
                Logger.logResponse((data: data, response: response))
            }).mapError { $0 as Error }
            .eraseToAnyPublisher()
    }
    
    func request(image url: String) -> AnyPublisher<UIImage, Error> {
        guard let url = URL(string: url) else { return Empty().eraseToAnyPublisher() }
        Logger.logRequest(URLRequest(url: url))
        if let cached = URLCache.shared.cachedResponse(for: URLRequest(url: url)),
           let image = UIImage(data: cached.data) {
            return Just(image)
                .setFailureType(to: Error.self)
                .eraseToAnyPublisher()
        }
        return URLSession.shared.dataTaskPublisher(for: url)
            .handleEvents(receiveOutput: { data, response in
                URLCache.shared.storeCachedResponse(CachedURLResponse(response: response, data: data), for: URLRequest(url: url))
            }).tryMap { data, response in
                guard let image = UIImage(data: data) else { throw URLError(.cannotDecodeContentData) }
                return image
            }.eraseToAnyPublisher()
    }
}
