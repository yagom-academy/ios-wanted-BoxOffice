//
//  APIRequest.swift
//  BoxOffice
//
//  Created by dhoney96 on 2023/01/02.
//

import Foundation

protocol APIRequest {
    var baseURL: BaseURL { get }
    var key: Key { get }
    var method: String { get }
    var query: Query { get }
}

extension APIRequest {
    //TODO: nil 대신 에러를 던질 건지 고민
    func configureRequest() -> URLRequest? {
        guard let url = self.configureURL() else {
            return nil
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = self.method
        
        return request
    }
    
    private func configureURL() -> URL? {
        var components = URLComponents(string: baseURL.rawValue)
        
        guard let keyItem = self.getURLQueryItem(from: self.key.dictionary),
              let queryItem = self.getURLQueryItem(from: query.dictionary) else {
            return nil
        }
        
        components?.queryItems = [keyItem, queryItem]
        
        return components?.url
    }
    
    private func getURLQueryItem(from dict: [String: String]) -> URLQueryItem? {
        guard let id = dict.first?.key,
              let value = dict[id] else {
            return nil
        }
        
        return URLQueryItem(name: id, value: value)
    }
}
