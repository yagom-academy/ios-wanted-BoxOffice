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
    
    var dateFormatterForKey: DateFormatter {
        self.formatter.dateFormat = "yyyyMMdd"
        return formatter
    }
    
    var dateFormatterForSectionHeader: DateFormatter {
        self.formatter.dateFormat = "yy년 M월 d일"
        return formatter
    }
    
    func convertToDateTitle() -> String {
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        let yesterDay = calendar.date(byAdding: .day, value: -1, to: date)
        
        return self.dateFormatterForSectionHeader.string(from: yesterDay!)
    }
    
    func convertToDateKey() -> String {
        let date = Date()
        let calendar = Calendar(identifier: .gregorian)
        let yesterDay = calendar.date(byAdding: .day, value: -1, to: date)
        
        return self.dateFormatterForKey.string(from: yesterDay!)
    }
}
