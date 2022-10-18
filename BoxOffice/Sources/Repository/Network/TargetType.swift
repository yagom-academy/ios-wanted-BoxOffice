//
//  TargetType.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/18.
//

import Foundation

protocol TargetType {
    var path: String { get }
    
    var request: URLRequest? { get }
    
    var baseURL: String { get }
}

extension TargetType {
    var fullPath: String {
        return "\(baseURL)\(path)"
    }
    
    func url(with param: Codable) -> URL? {
        var components = URLComponents(string: fullPath)
        components?.queryItems = try? param.asURLQuerys()
        return components?.url
    }
    
    func request(with param: Codable) -> URLRequest? {
        var components = URLComponents(string: fullPath)
        components?.queryItems = try? param.asURLQuerys()
        guard let url = components?.url else { return nil }
        return URLRequest(url: url)
    }
}
