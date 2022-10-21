//
//  UIImageView+.swift
//  BoxOffice
//
//  Created by sole on 2022/10/21.
//

import UIKit

extension UIImageView {
    func isCorner(radius: CGFloat) {
        self.layer.cornerRadius = radius
        self.clipsToBounds = true
    }
}
