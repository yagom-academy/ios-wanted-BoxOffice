//
//  URLManager.swift
//  BoxOffice
//
//  Created by sole on 2022/10/21.
//

import Foundation

enum URLManager {
    case kobisBoxoffice
    case kobisMovieInfo
    case tmdbAssetInfo
    
    static let tmdbImageURL = "https://image.tmdb.org/t/p/w500/"
    
    static func createKobisBoxOfficeURL(targetDate: Date) throws -> URL {
        var urlComponents = URLComponents(string: URLManager.kobisBoxoffice.baseURL)
        let appIdQuery = URLQueryItem(name: "key", value: URLManager.kobisBoxoffice.key)
        let targetDateQuery = URLQueryItem(name: "targetDt", value: targetDate.convertToStringTypeForSearch)
        urlComponents?.queryItems?.append(contentsOf: [appIdQuery, targetDateQuery])
        
        guard let url: URL = urlComponents?.url else {
            throw URLError.invalidKobisBoxOfficeURL
        }
        return url
    }
    
    static func createKobisMovieInfoURL(movieCode: String) throws -> URL {
        var urlComponents = URLComponents(string: URLManager.kobisMovieInfo.baseURL)
        let appIdQuery = URLQueryItem(name: "key", value: URLManager.kobisBoxoffice.key)
        let movieCodeQuery = URLQueryItem(name: "movieCd", value: movieCode)
        urlComponents?.queryItems?.append(contentsOf: [appIdQuery, movieCodeQuery])
        
        guard let url: URL = urlComponents?.url else {
            throw URLError.invalidKobisMovieInfoURL
        }
        return url
    }
    
    static func createTmdbURL(movieNameInEnglish: String) throws -> URL {
        var urlComponents = URLComponents(string: URLManager.tmdbAssetInfo.baseURL)
        let appIdQuery = URLQueryItem(name: "api_key", value: URLManager.tmdbAssetInfo.key)
        let movieNameQuery = URLQueryItem(name: "query", value: movieNameInEnglish)
        let languageQuery = URLQueryItem(name: "language", value: "ko")
        let yearQuery = URLQueryItem(name: "year", value: "2022")
        urlComponents?.queryItems?.append(contentsOf: [appIdQuery, movieNameQuery, languageQuery, yearQuery])
        
        guard let url: URL = urlComponents?.url else {
            throw URLError.invalidKobisTmdbAssetURL
        }
        return url
    }
    
    private var key: String {
        switch self {
        case .kobisBoxoffice, .kobisMovieInfo: return "b089f44ca1fabdcdc12ff5d0eef44052"
        case .tmdbAssetInfo: return "52b9f149066f4c2295ce7f935812e6de"
        }
    }
    
    private var baseURL: String {
        switch self {
        case .kobisBoxoffice: return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?"
        case .kobisMovieInfo: return "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?"
        case .tmdbAssetInfo: return "https://api.themoviedb.org/3/search/movie/?"
        }
    }
}
