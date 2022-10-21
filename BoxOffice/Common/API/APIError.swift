//
//  APIError.swift
//  BoxOffice
//
//  Created by 신병기 on 2022/10/19.
//

import Foundation

enum APIError: Error {
    case invalidURL
    
    case failHTTPStatus
    
    case failResponseDecording
}
