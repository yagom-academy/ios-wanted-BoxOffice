//
//  NetworkError.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/19.
//

enum NetworkError: Error {
    case pathErr
    case serverErr
    case decodedErr
    case invalidErr
    case networkFail
    case imageCacheErr
}
