//
//  HTTPMehtod.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

import Foundation

enum HTTPMethod {
    case get
    case post
    case delete
    case patch
    
    var name: String {
        switch self {
        case .get:
            return "GET"
        case .post:
            return "POST"
        case .delete:
            return "DELETE"
        case .patch:
            return "PATCH"
        }
    }
}
