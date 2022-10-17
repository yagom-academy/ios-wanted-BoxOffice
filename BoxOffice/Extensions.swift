//
//  Extensions.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/17.
//

import UIKit

extension NSLayoutConstraint {
    func withMultiplier(multiplier:CGFloat) -> NSLayoutConstraint {
        return NSLayoutConstraint(item: firstItem!, attribute: firstAttribute, relatedBy: relation, toItem: secondItem, attribute: secondAttribute, multiplier: multiplier, constant: constant)
    }
}
