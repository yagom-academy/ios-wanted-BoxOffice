//
//  APIError.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

import Foundation

enum APIError: LocalizedError {
    case unknownError(_ error: Error)
    case invalidRequest
    case invalidResponse
    case abnormalStatusCode(_ statusCode: Int)
    case emptyData
    case failedToParse

    var errorDescription: String? {
        switch self {
        case .unknownError(let error):
            return "Unknown error: \(error.localizedDescription)"
        case .invalidRequest:
            return "URLRequest is not valid."
        case .invalidResponse:
            return "URLResponse is not valid."
        case .abnormalStatusCode(let statusCode):
            return "Abnormal Status Code \(statusCode) is found"
        case .emptyData:
            return "There is no data."
        case .failedToParse:
            return "Falied to parse response data."
        }
    }
}
