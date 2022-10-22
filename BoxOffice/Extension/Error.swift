//
//  Error.swift
//  BoxOffice
//
//  Created by sole on 2022/10/21.
//

import Foundation

// TODO: - localizedDescription 반영
enum URLError: Error {
    case invalidKobisBoxOfficeURL
    case invalidKobisMovieInfoURL 
    case invalidTmdbAssetURL
    case invalidTmdbTrailerURL
    case invalidTmdbPosterURL
    
    var localizedDescription: String {
        switch self{
        case .invalidKobisBoxOfficeURL: return "KobisBoxOfficeURL이 유효하지 않습니다."
        case .invalidKobisMovieInfoURL: return "KobisMovieInfoURL이 유효하지 않습니다."
        case .invalidTmdbAssetURL: return "TmdbAssetURL이 유효하지 않습니다."
        case .invalidTmdbTrailerURL: return "TmdbTrailerURL이 유효하지 않습니다."
        case .invalidTmdbPosterURL: return "TmdbPosterURL이 유효하지 않습니다."
        }
    }
}

enum ConvertError: Error {
    case toDateType
    case toMovieType
    
    var localizedDescription: String {
        switch self{
        case .toDateType: return "DateType으로 변환하는데 실패했습니다."
        case .toMovieType: return "MovieType으로 변환하는데 실패했습니다."
        }
    }
}

enum ParseError: Error {
    case failToKobisBoxOfficeDataDecoding
    case failToKobisMovieDataDecoding
    case failToTmdbAssetDataDecoding
    
    var localizedDescription: String {
        switch self {
        case .failToKobisBoxOfficeDataDecoding:
            return "KobisBoxOfficeData를 디코딩하는데 실패했습니다."
        case .failToKobisMovieDataDecoding:
            return "KobisMovieData를 디코딩하는데 실패했습니다."
        case .failToTmdbAssetDataDecoding:
            return "TmdbAssetDAta를 디코딩하는데 실패했습니다."
        }
    }
}

enum APIError: Error {
    case response
    
    var localizedDescription: String {
        switch self {
        case .response: return "API Response가 정상범위에 있지 않습니다."
        }
    }
}

enum ImageError: Error {
    case failToLoad
    case notcached
    
    var localizedDescription: String {
        switch self {
        case .failToLoad: return "이미지를 로드하지 못했습니다."
        case .notcached: return "캐시된 이미지가 없습니다."
        }
    }
}
