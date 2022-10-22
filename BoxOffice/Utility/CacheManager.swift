//
//  CacheManager.swift
//  BoxOffice
//
//  Created by sole on 2022/10/22.
//

import UIKit

final class CacheManager {
    static private let cachedImage = NSCache<NSString, UIImage>()
    
    static func searchCachedImage(with path: String) -> UIImage? {
        let cacheKey = NSString(string: path)
        guard let image = cachedImage.object(forKey: cacheKey) else {
            return nil
        }
        return image
    }
    
    static func imageCacheAndGet(with path: String) async throws -> UIImage {
        let url = try URLManager.createTmdbPosterURL(with: path)
        let cacheKey = NSString(string: path)
        let data = try await APIManager.fetchData(url: url)
        guard let image = UIImage(data: data) else {
            throw ImageError.notcached
        }
        cachedImage.setObject(image, forKey: cacheKey)
        return image
    }
}
