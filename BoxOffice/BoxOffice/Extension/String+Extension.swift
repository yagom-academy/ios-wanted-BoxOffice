//
//  String+Extension.swift
//  BoxOffice
//
//  Created by brad on 2023/01/04.
//

import Foundation
import SwiftUI

extension String {
    var insertComma: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        
        return numberFormatter.string(for: Double(self)) ?? self
    }
    
    var dateYearFormatter: Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy. MM. dd"
        
        return dateFormatter.date(from: self) ?? Date()
    }
    
    var convertInt: Int {
        return Int(self) ?? 0
    }
}
