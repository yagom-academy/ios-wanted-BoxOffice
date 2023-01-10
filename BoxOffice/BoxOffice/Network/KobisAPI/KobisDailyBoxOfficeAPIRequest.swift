//
//  KobisDailyBoxOfficeAPIRequest.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

import Foundation

struct KobisDailyBoxOfficeAPIRequest: KobisAPIRequest {
    
    typealias APIResponse = DailyBoxOfficeResponse
    
    var path: URLPath? = .dailyBoxOfficeList
    var headers: [String : String]?
    var body: Data?
}
