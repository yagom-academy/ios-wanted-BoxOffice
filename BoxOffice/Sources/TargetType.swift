//
//  TargetType.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation

protocol TargetType {
    
    var path: String { get }
    
    var request: URLRequest? { get }
    
    var baseURL: String { get }
    
    var method: HTTPMethod { get }
    
    var headers: [String: String]? { get }
    
}

extension TargetType {
    
    func url(with param: Codable) -> URL? {
        guard let baseURL = URL(string: self.baseURL) else {
            return nil
        }
        let url = baseURL.appendingPathComponent(self.path)
        var urlComponents = URLComponents(string: url.absoluteString)
        let urlQuries = try? param.asURLQuerys()
        if urlQuries?.isEmpty == false {
            urlComponents?.percentEncodedQueryItems = urlQuries
        }
        return urlComponents?.url ?? url
    }
    
    func request(with param: Codable) -> URLRequest? {
        guard let url = self.url(with: param) else {
            return nil
        }
        var request = URLRequest(url: url)
        request.httpMethod = self.method.rawValue
        if let headers = self.headers {
            headers.forEach { key, value in
                request.addValue(value, forHTTPHeaderField: key)
            }
        }
        return request
    }
    
}

enum HTTPMethod: String {
    case get = "GET"
}
