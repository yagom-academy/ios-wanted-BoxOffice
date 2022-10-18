//
//  TargetType.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/18.
//

import Foundation

protocol TargetType {
    var path: String { get }
    
    var request: URLRequest? { get }
    
    var baseURL: String { get }
}

extension TargetType {
    var fullPath: String {
        return "\(baseURL)\(path)"
    }
}
