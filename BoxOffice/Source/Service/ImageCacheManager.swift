//
//  ImageCacheManager.swift
//  BoxOffice
//
//  Created by KangMingyo on 2022/10/20.
//

import UIKit

class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
