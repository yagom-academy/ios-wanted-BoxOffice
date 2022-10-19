//
//  OmdbAPI.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/18.
//

import Foundation

enum OmdbAPI: TargetType {
    case moviePoster(MoviePosterRequest)
    
    var path: String {
        switch self {
        case .moviePoster:
            return ""
        }
    }
    
    var baseURL: String {
        return "https://www.omdbapi.com/"
    }
    
    var request: URLRequest? {
        switch self {
        case .moviePoster(let param):
            return request(with: param)
        }
    }
}

// MARK: Request
struct MoviePosterRequest: Codable {
    var apikey: String
    var t: String
}

// MARK: Response
struct MoviePosterResponse: Codable {
    let response: String
    let poster: String?
    
    private enum CodingKeys: String, CodingKey {
        case response = "Response"
        case poster = "Poster"
    }
}
