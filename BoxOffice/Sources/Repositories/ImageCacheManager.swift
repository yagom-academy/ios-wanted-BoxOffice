//
//  ImageCacheManager.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import UIKit
import Combine

final class ImageCacheManager {
    
    private let cache = NSCache<NSString, UIImage>()
    static let shared = ImageCacheManager()
    
    private init() {}
    
    func loadCachedData(for key: String) -> UIImage? {
        let itemURL = NSString(string: key)
        return cache.object(forKey: itemURL)
    }
    
    func setCacheData(of image: UIImage, for key: String) {
        let itemURL = NSString(string: key)
        cache.setObject(image, forKey: itemURL)
    }
    
}
