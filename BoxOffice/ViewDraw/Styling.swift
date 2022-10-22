//
//  Styling.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import Foundation
import UIKit

protocol BasicNavigationBarStyling { }

extension BasicNavigationBarStyling {
    
    var dateButtonStyle: (UIBarButtonItem) -> () {
        {
            $0.image = UIImage(systemName: .calendar)
            $0.tintColor = .black
        }
    }
    
    var navigationBarStyle: (UINavigationBar) -> () {
        {
            $0.shadowImage = UIImage() //default: nil
            $0.isTranslucent = true
            $0.titleTextAttributes = [.foregroundColor : UIColor.black]
        }
    }
}

protocol Styleable { }

extension UIView: Styleable { }
extension UIBarButtonItem: Styleable { }
extension UINavigationItem: Styleable { }

extension Styleable {
    @discardableResult
    func addStyles(style: (Self) -> ()) -> Self {
        style(self)
        return self
    }
}
