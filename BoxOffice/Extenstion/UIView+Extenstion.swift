//
//  UIView+Extenstion.swift
//  BoxOffice
//
//  Created by 김지인 on 2022/10/17.
//

import UIKit

extension UIView {
    func addSubViewsAndtranslatesFalse(_ views: UIView...) {
        views.forEach(self.addSubview(_:))
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
    }
}
