//
//  ImageCacheManager.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/06.
//

import UIKit

class ImageCacheManager {
    static let shared =  ImageCacheManager()
    private let cachedImages = NSCache<NSString, UIImage>()
    
    private init() {}
    
    func getCachedImage(url: NSString) -> UIImage? {
        let key = NSString(string: url)
        return cachedImages.object(forKey: key)
    }
    
    func saveCache(image: UIImage, url: String) {
        let key = NSString(string: url)
        cachedImages.setObject(image, forKey: key)
    }
}
