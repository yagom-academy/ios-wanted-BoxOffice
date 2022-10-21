//
//  ParseManager.swift
//  BoxOffice
//
//  Created by sole on 2022/10/21.
//

import Foundation

enum ParseManager {
    static func parse(_ data: Data) throws -> [KobisDailyBoxOfficeList] {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(KobisBoxOfficeResponse.self, from: data)
            return decodeData.results.dailyBoxOfficeList
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        }
        throw ParseError.failToKobisBoxOfficeDataDecoding
    }
    
    static func parse(_ data: Data) throws -> KobisMovieInfo {
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(KobisMovieInfoResponse.self, from: data)
            return decodeData.results.movieInfo
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.valueNotFound(value, context) {
            print("Value '\(value)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } catch let DecodingError.typeMismatch(type, context)  {
            print("Type '\(type)' mismatch:", context.debugDescription)
            print("codingPath:", context.codingPath)
        }
        throw ParseError.failToKobisMovieDataDecoding
    }
    
    static func parse(_ data: Data?) throws -> TmdbAsset? {
        guard let data = data else { return nil }
        let decoder = JSONDecoder()
        do {
            let decodeData = try decoder.decode(TMDBResponse.self, from: data)
            return decodeData.results?.first
        } catch let DecodingError.dataCorrupted(context) {
            print(context)
        } catch let DecodingError.keyNotFound(key, context) {
            print("Key '\(key)' not found:", context.debugDescription)
            print("codingPath:", context.codingPath)
        } 
        throw ParseError.failToTmdbAssetDataDecoding
    }
}
