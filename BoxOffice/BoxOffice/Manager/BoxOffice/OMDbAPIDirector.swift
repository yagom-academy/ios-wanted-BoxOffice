//
//  OMDbAPIDirector.swift
//  BoxOffice
//
//  Created by 유한석 on 2023/01/03.
//

import Foundation

struct OMDbRequest: APIRequest {
    var method: HTTPMethod
    var baseURL: String
    var path: String
    var query: [String: String]
}

final class OMDbRequestBuilder {
    private var method: HTTPMethod?
    private var baseURL: String
    private var path: OMDbRequestPath?
    private var query: [String: String]
    
    init() {
        self.baseURL = OMDbHostAPI.omdbHost.rawValue
        self.query = [:]
    }
    
    func setBaseURL(_ url: String) -> OMDbRequestBuilder  {
        self.baseURL = url
        return self
    }
    
    func setMethod(_ method: HTTPMethod) -> OMDbRequestBuilder {
        self.method = method
        return self
    }
    
    func setPath(_ path: OMDbRequestPath) -> OMDbRequestBuilder {
        self.path = path
        return self
    }
    
    func setKey() -> OMDbRequestBuilder {
        self.query["apikey"] = OMDbAPIKey.omdbKey.rawValue
        return self
    }
    
    func addQuery(queryItems: [String: String]) -> OMDbRequestBuilder {
        for queryItem in queryItems {
            self.query[queryItem.key] = queryItem.value
        }
        return self
    }
    
    func queryInitialization() {
        self.query = [:]
    }
    
    func buildRequest() -> OMDbRequest? {
        guard let method = method, let path = path else {
            return nil
        }
        
        let omdbRequest = OMDbRequest(
            method: method,
            baseURL: baseURL,
            path: path.rawValue,
            query: query
        )
        
        return omdbRequest
    }
}

struct OMDbRequestDirector {
    private let builder: OMDbRequestBuilder
    
    init(_ builder: OMDbRequestBuilder = OMDbRequestBuilder()) {
        self.builder = builder
    }
    
    func createGetRequest(queryItems: [String: String], type: OMDbRequestPath) -> OMDbRequest? {
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
