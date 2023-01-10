//
//  UIView+.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/03.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addSubview($0)
        }
    }
}
