//
//  File.swift
//  BoxOffice
//
//  Created by 박도원 on 2023/01/06.
//

import Foundation

struct BoxOfficeResult: Decodable, Hashable {
    let boxofficeType: String
    let dailyBoxOfficeList: [DailyBoxOfficeList]
}
