//
//  Int+.swift
//  BoxOffice
//
//  Created by sole on 2022/10/22.
//

import Foundation

extension Int {
    var convertDecimalStringType: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        guard let result = numberFormatter.string(from: NSNumber(value: self)) else { return "" }
        return result
    }
}
