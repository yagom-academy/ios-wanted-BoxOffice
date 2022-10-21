//
//  NSMutableAttributedString+Extension.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/21.
//

import Foundation
import UIKit

extension NSMutableAttributedString {
    func setAttributesForAll(_ attrs: [NSAttributedString.Key : Any]?) {
        self.setAttributes(attrs, range: NSRange(location: 0, length: self.length))
    }
}
