//
//  UIStackView+Extenstion.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/20.
//

import UIKit

extension UIStackView {
    func addArrangedSubViews(_ views: UIView...) {
        views.forEach { self.addArrangedSubview($0) }
    }
}
