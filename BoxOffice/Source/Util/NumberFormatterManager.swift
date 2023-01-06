//
//  NumberFormatterManager.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/06.
//

import Foundation

class NumberFormatterManager {
    static let shared = NumberFormatterManager()
    private let formatter = NumberFormatter()
    
    var audienceNumberFormatter: NumberFormatter {
        self.formatter.numberStyle = .decimal
        self.formatter.roundingMode = .ceiling
        self.formatter.maximumFractionDigits = 0
        return formatter
    }
    
    private init() { }
    
    func getAudience(from number: String) -> String? {
        guard let number = Int(number) else {
            return nil
        }
        
        if number / 10000 == 0 {
            return audienceNumberFormatter.string(for: number)
        } else {
            let newNumber = Double(number) / Double(10000)
            return audienceNumberFormatter.string(for: newNumber)! + "만"
        }
    }
}
