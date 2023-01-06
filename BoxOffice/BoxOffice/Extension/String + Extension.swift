//
//  String + Extension.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/04.
//

import Foundation

extension String {
    var numberOfPeople: String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal

        guard let returnValue = numberFormatter.string(from: NSNumber(value: Int(self) ?? 0)) else { return "" }
        return returnValue
    }

    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }

        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1)

        return String(self[startIndex ..< endIndex])
    }
}
