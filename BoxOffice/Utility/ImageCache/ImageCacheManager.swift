//
//  ImageCacheManager.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/04.
//

import UIKit

protocol ImageCacheManager {
    func getImage(with imageURL: URL?) async throws -> UIImage?
}

final class URLCacheManager: ImageCacheManager {
    private let cache = URLCache.shared
    private var dataTask: URLSessionDataTask?
    
    func getImage(with imageURL: URL?) async throws -> UIImage? {
        guard let imageURL = imageURL else { return nil }
        let request = URLRequest(url: imageURL)
        
        if self.cache.cachedResponse(for: request) != nil {
            let image = self.loadImageFromCache(with: imageURL)
            return image
        } else {
            let image = try await self.downloadImage(with: imageURL)
            return image
        }
    }
    
    func loadImageFromCache(with imageURL: URL) -> UIImage? {
        let request = URLRequest(url: imageURL)
        
        guard let data = self.cache.cachedResponse(for: request)?.data,
              let image = UIImage(data: data) else { return nil }
        return image
    }
    
    func downloadImage(with imageURL: URL) async throws -> UIImage? {
        let request = URLRequest(url: imageURL)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        let cachedData = CachedURLResponse(response: response, data: data)
        self.cache.storeCachedResponse(cachedData, for: request)
        guard let image = UIImage(data: data) else { return nil }
        return image
    }
}
