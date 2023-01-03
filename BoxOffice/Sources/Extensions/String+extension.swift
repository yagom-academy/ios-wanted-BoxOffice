//
//  String+extension.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation

extension String {
    
    func asDate(format: DateFormat = .yyyyMMddHypen) -> Date? {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.date(from: self)
    }
    
}

enum DateFormat: String {
    case yyyyMMdd = "yyyyMMdd"
    case yyyyMMddDot = "yyyy.MM.dd"
    case yyyyMMddHypen = "yyyy-MM-dd"
}
