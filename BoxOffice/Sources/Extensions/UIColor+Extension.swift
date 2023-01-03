//
//  UIColor+Extension.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/03.
//

import UIKit

extension UIColor {
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
}
