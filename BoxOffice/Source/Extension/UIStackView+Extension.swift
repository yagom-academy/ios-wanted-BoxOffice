//
//  UIStackView+Extension.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/19.
//

import UIKit.UIStackView

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach { addArrangedSubview($0) }
    }
}
