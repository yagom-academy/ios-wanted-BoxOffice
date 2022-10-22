//
//  UIImage+Extension.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/22.
//

import UIKit

extension UIImage {

    func isEqual(_ image: UIImage) -> Bool {
        pngData() == image.pngData()
    }

}
