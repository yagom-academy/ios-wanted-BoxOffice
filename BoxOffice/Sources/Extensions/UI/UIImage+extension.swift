//
//  UIImage+extension.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/05.
//

import UIKit

extension UIImage {
    var toString: String? {
        get {
            return self.jpegData(compressionQuality: 1.0)?.base64EncodedString()
        }
    }
}
