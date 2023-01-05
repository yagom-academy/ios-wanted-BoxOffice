//
//  ImageCacheManager.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/06.
//

import UIKit

public class ImageCacheManager {
    public static let shared =  ImageCacheManager()
    private init() {}

    private let cachedImages = NSCache<NSString, UIImage>()

    func getCachedImage(url: NSString) -> UIImage? {
        let key = NSString(string: url)
        return cachedImages.object(forKey: key)
    }
    
    func saveCache(image: UIImage, url: String) {
        let key = NSString(string: url)
        cachedImages.setObject(image, forKey: key)
    }
}
