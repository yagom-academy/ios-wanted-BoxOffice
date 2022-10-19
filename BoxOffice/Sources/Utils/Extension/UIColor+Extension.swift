//
//  UIColor+Extension.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/19.
//

import Foundation
import UIKit

extension UIColor {
    convenience init(hex: String, alpha: CGFloat = 1) {
        let hex = Array(hex)
        let red = hexToCGFloat(from: hex[1..<3])
        let green = hexToCGFloat(from: hex[3..<5])
        let blue = hexToCGFloat(from: hex[5..<7])
        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
}

private func hexToCGFloat(from hex: ArraySlice<Character>) -> CGFloat {
    CGFloat(Int(String(hex), radix: 16)!) / 255.0
}
