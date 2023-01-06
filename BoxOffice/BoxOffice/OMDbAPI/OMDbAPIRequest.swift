//
//  OMDbAPIRequest.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/04.
//

import Foundation

protocol OMDbAPIRequest: APIRequest { }

extension OMDbAPIRequest {
    var host: URLHost {
        .OMDB
    }

    var httpMethod: HTTPMethod {
        .get
    }
}

