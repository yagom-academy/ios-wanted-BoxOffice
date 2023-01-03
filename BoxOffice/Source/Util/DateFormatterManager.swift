//
//  DateFormatterManager.swift
//  BoxOffice
//
//  Created by dhoney96 on 2023/01/03.
//

import Foundation

class DateFormatterManager {
    static let shared = DateFormatterManager()
    private let formatter = DateFormatter()
    
    var dateFormatter: DateFormatter {
        self.formatter.dateFormat = "yyyyMMdd"
        return formatter
    }
    
    func convertToDateString(from date: Date) -> String {
        return self.dateFormatter.string(from: date)
    }
}
