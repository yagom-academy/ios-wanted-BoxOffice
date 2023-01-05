//
//  UIStackView+Extension.swift
//  BoxOffice
//
//  Created by 우롱차 on 2023/01/06.
//
import UIKit

extension UIStackView {
    func addArrangedSubviews(_ views: UIView...) {
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            addArrangedSubview($0)
        }
    }
}
