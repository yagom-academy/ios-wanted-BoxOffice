//
//  UIImage+Extension.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import Foundation
import UIKit

extension UIImage {
    convenience init?(systemName: ImageName) {
        self.init(systemName: systemName.rawValue)
    }
    
    convenience init?(imageName: String) {
        self.init(named: imageName)
    }
}

enum ImageName: String {
    case errorImage = "exclamationmark.circle.fill"
}
