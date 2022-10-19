//
//  RequestType.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/19.
//

import Foundation

enum HTTPMethod: String {

    case get = "GET"
    case post = "POST"
    case put = "PUT"
    case delete = "DELETE"

}

typealias HTTPParameters = [String: String]

protocol RequestType {

    associatedtype ResponseDataType: Decodable

    var baseURL: String { get }
    var path: String { get }
    var method: HTTPMethod { get }
    var parameters: HTTPParameters? { get }

}

// MARK: - Public

extension RequestType {

    func makeRequest()  throws -> URLRequest {
        guard let url = url else {
            throw NetworkError.createURLRequestFailed
        }
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        return request
    }

    func parseResponse(data: Data) throws -> ResponseDataType {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        return try decoder.decode(ResponseDataType.self, from: data)
    }

}

// MARK: - Private

extension RequestType {

    private var url: URL? {
        guard var urlComponents = URLComponents(string: baseURL) else {
            return nil
        }
        urlComponents.path = urlComponents.path + path
        urlComponents.queryItems = queryItems
        return urlComponents.url
    }

    private var queryItems: [URLQueryItem]? {
        guard method == .get, let parameters = parameters else {
            return nil
        }

        return parameters.map {
            return URLQueryItem(name: $0.key, value: $0.value)
        }
    }

}
