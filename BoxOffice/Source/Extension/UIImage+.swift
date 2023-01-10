//
//  UIImage+.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/06.
//

import UIKit

extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale

        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }

        return renderImage
    }
    
    var toBase64: String? {
        self.jpegData(compressionQuality: 1)?.base64EncodedString()
    }
}
