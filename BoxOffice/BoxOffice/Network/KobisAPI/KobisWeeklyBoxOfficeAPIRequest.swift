//
//  KobisWeeklyBoxOfficeAPIRequest.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

import Foundation

struct KobisWeeklyBoxOfficeAPIRequest: KobisAPIRequest {
    
    typealias APIResponse = WeeklyBoxOfficeResponse
    
    var path: URLPath? = .weeklyBoxOfficeList
    var headers: [String : String]?
    var body: Data?
}
