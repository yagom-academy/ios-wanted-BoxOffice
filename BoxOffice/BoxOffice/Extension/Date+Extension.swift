//
//  Date+Extension.swift
//  BoxOffice
//
//  Created by brad on 2023/01/04.
//

import Foundation

extension Date {
    var dateFormatter: DateFormatter {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        
        return dateFormatter
    }
    
    func translateToString() -> String {
        
        return dateFormatter.string(from: self)
    }
    
    func translateToYearString() -> String {
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy. MM. dd"
        
        return dateFormatter2.string(from: self)
    }
}
