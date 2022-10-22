//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/19.
//

import Foundation

extension Date {
    static var yesterDay: Date! {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date())
    }
    
    static var lastWeek: Date! {
        return Calendar.current.date(byAdding: .day, value: -7, to: Date())
    }
    
    func toString(_ format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
}

enum DateFormat: String {
    case yyyyMMdd = "yyyyMMdd"
    case yyyyMMddDot = "yyyy.MM.dd"
    case yyyyMMddHypen = "yyyy-MM-dd"
}
