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
    
    private func resize(percentage: CGFloat) -> UIImage {
        let size = CGSize(width: size.width * percentage, height: size.height * percentage)
        return UIGraphicsImageRenderer(size: size, format: imageRendererFormat).image { _ in
            draw(in: CGRect(origin: .zero, size: size))
        }
    }
    
    func compress() -> UIImage {
        var compressedImage = self
        var quality: CGFloat = 1
        let maxDataSize = 307200
        guard var compressedImageData = compressedImage.jpegData(compressionQuality: 1) else {
            return UIImage()
        }
        while compressedImageData.count > maxDataSize {
            quality *= 0.8
            compressedImage = compressedImage.resize(percentage: quality)
            compressedImageData = compressedImage.jpegData(compressionQuality: quality) ?? Data()
        }
        return compressedImage
    }
}
