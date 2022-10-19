//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/19.
//

import Foundation

extension Date {
    enum DateFormat: String {
        case koficFormat = "yyyyMMdd" //20221017
    }
    
    func asString(_ format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.locale = Locale(identifier: "ko")
        formatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}
