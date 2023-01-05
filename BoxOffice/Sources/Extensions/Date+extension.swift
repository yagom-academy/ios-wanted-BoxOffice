//
//  Date+extension.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation

extension Date {
    
    static var yesterday: Date {
        return Calendar.current.date(byAdding: .day, value: -1, to: Date()) ?? Date()
    }
    
    static var lastWeek: Date {
        return Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
    }
    
    func toString(_ format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
}
