//
//  BoxOfficeAPIManager.swift
//  BoxOffice
//
//  Created by 유한석 on 2023/01/03.
//

import Foundation

struct MovieRequest: APIRequest {
    var method: HTTPMethod
    var baseURL: String
    var path: String
    var query: [String:String]
}

final class MovieRequestBuilder {
    private var method: HTTPMethod?
    private var baseURL: String
    private var path: MovieRequestPath?
    private var query: [String:String]
    
    init() {
        self.baseURL = BoxOfficeHostAPI.dailyBoxOffice.rawValue
        self.query = [:]
    }
    
    func setBaseURL(_ url: String) -> MovieRequestBuilder  {
        self.baseURL = url
        return self
    }
    
    func setMethod(_ method: HTTPMethod) -> MovieRequestBuilder {
        self.method = method
        return self
    }
    
    func setPath(_ path: MovieRequestPath) -> MovieRequestBuilder {
        self.path = path
        return self
    }
    
    func setKey() -> MovieRequestBuilder {
        self.query["key"] = BoxOfficeAPIKey.boxOfficeKey.rawValue
        return self
    }
    
    func addQuery(queryItems: [String: String]) -> MovieRequestBuilder {
        for queryItem in queryItems {
            self.query[queryItem.key] = queryItem.value
        }
        return self
    }
    
    func queryInitialization() {
        self.query = [:]
    }
    
    func buildRequest() -> MovieRequest? {
        
        guard let method = method, let path = path else {
            return nil
        }
        
        let movieRequest = MovieRequest(
            method: method,
            baseURL: baseURL,
            path: path.rawValue,
            query: query
        )
        
        return movieRequest
    }
}

struct MovieRequestDirector {
    private let builder: MovieRequestBuilder
    
    init(_ builder: MovieRequestBuilder = MovieRequestBuilder()) {
        self.builder = builder
    }
    
    func createGetRequest(queryItems: [String: String], type: MovieRequestPath) -> MovieRequest? {
        
        builder.queryInitialization()
        let getRequest = builder
            .setMethod(.get)
            .setPath(type)
            .setKey()
            .addQuery(queryItems: queryItems)
            .buildRequest()
    
        return getRequest
    }
}
