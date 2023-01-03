//
//  OmdbAPI.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation

enum OmdbAPI: TargetType {
    
    case moviePoster(MoviePosterRequest)
    
    var path: String {
        switch self {
        case .moviePoster: return ""
        }
    }
    
    var baseURL: String {
        return "https://www.omdbapi.com/"
    }
    
    var method: HTTPMethod {
        return .get
    }
    
    var headers: [String : String]? {
        return [:]
    }
    
    var request: URLRequest? {
        switch self {
        case .moviePoster(let param): return request(with: param)
        }
    }
    
}

struct MoviePosterRequest: Codable {
    
    let apiKey: String
    let t: String
}
