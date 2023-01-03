//
//  UIImage+Extension.swift
//  BoxOffice
//
//  Created by 우롱차 on 2023/01/03.
//

import UIKit

extension UIImage {
    var toString: String? {
        get {
            return self.jpegData(compressionQuality: 1.0)?.base64EncodedString() ?? nil
        }
    }
}
