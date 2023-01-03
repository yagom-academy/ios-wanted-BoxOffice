//
//  KobisAPIRequest.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

import Foundation

protocol KobisAPIRequest: APIRequest { }

extension KobisAPIRequest {
    var host: URLHost {
        .kobis
    }
    
    var httpMethod: HTTPMethod {
        .get
    }
    
    var queryItems: [String : String]? {
        [
            "key": "019dfeab346ca4bdaa25268affad110a",
            "targetDt": "20220101",
            "wideAreaCd": "0105001"
        ]
    }
}
