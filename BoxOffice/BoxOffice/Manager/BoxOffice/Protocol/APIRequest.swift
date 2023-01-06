//
//  APIRequest.swift
//  BoxOffice
//
//  Created by 유한석 on 2023/01/03.
//

import Foundation.NSURL

protocol APIRequest {
    var method: HTTPMethod { get }
    var baseURL: String { get }
    var path: String { get }
    var query: [String: String] { get }
}

extension APIRequest {
    var url: URL? {
        var urlBodyComponents = URLComponents(string: baseURL + path)
        var urlQueryComponents: [URLQueryItem] = []
        
        for queryItems in query {
            let urlQueryComponent = URLQueryItem(name: queryItems.key, value: queryItems.value)
            urlQueryComponents.append(urlQueryComponent)
        }
        urlBodyComponents?.queryItems = urlQueryComponents
        
        return urlBodyComponents?.url
    }
    
    var urlRequest: URLRequest? {
        guard let url = self.url else {
            return nil
        }
        
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = method.rawValue
        
        return urlRequest
    }
}
