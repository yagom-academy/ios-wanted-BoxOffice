//
//  HTTPMethod.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/02.
//

import Foundation

enum HTTPMethod: String, CustomStringConvertible {
    case get
    case post
    case put
    case delete
    
    var description: String {
        rawValue
    }
}
