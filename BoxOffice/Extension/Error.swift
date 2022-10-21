//
//  Error.swift
//  BoxOffice
//
//  Created by sole on 2022/10/21.
//

import Foundation

// TODO: - localizedDescription

enum URLError: Error {
    case invalidKobisBoxOfficeURL
    case invalidKobisMovieInfoURL 
    case invalidKobisTmdbAssetURL
    case invalidTmdbTrailerURL
}

enum ConvertError: Error {
    case toDateType
    case toMovieType
}

enum ParseError: Error {
    case failToKobisBoxOfficeDataDecoding
    case failToKobisMovieDataDecoding
    case failToTmdbAssetDataDecoding
}

enum APIError: Error {
    case response
}

enum ImageError: Error {
    case failToLoad
}
