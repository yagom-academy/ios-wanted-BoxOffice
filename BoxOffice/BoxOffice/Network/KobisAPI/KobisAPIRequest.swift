//
//  KobisAPIRequest.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

import Foundation

enum BoxOfficeItemPerPage: String {
    case constant = "10"
}

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
            "targetDt": Calendar.current.date(byAdding: .day, value: -1, to: Date())?.now ?? "",
            "wideAreaCd": "0105001",
            "itemPerPage": BoxOfficeItemPerPage.constant.rawValue
        ]
    }
}
