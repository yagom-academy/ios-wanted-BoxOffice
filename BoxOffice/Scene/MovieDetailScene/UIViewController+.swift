//
//  UIViewController+.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/06.
//

import UIKit

extension UIViewController {
    func showAlert(title: String = "", message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인",
                                      style: .default))
        self.present(alert, animated: true)
    }
}
