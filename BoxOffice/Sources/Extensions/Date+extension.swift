//
//  Date+extension.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation

extension Date {
    
    func toString(_ format: DateFormat) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format.rawValue
        return formatter.string(from: self)
    }
    
}
