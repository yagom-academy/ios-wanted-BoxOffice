//
//  ImageCacheManager.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/19.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSString, UIImage>()
    private init() {}
}
