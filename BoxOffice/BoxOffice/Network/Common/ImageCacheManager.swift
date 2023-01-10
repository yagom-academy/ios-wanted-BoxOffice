//
//  ImageCacheManager.swift
//  BoxOffice
//
//  Created by unchain on 2023/01/05.
//

import UIKit

final class ImageCacheManager {
    static let shared = NSCache<NSURL, UIImage>()

    private init() {}
}
