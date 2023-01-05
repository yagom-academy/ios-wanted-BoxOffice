//
//  ImageCacheManager.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/04.
//

import UIKit

protocol ImageCacheManager {
    func getImage(with imageURL: URL, _ completion: @escaping (UIImage) -> Void)
}

final class URLCacheManager: ImageCacheManager {
    private let cache = URLCache.shared
    private var dataTask: URLSessionDataTask?
    
    func getImage(with imageURL: URL, _ completion: @escaping (UIImage) -> Void) {
        let request = URLRequest(url: imageURL)
        if self.cache.cachedResponse(for: request) != nil {
            self.loadImageFromCache(with: imageURL) { image in
                completion(image)
            }
        } else {
            self.downloadImage(with: imageURL) { image in
                completion(image)
            }
        }
    }
    
    func loadImageFromCache(with imageURL: URL, _ completion: @escaping (UIImage) -> Void) {
        let request = URLRequest(url: imageURL)
        
        if let data = self.cache.cachedResponse(for: request)?.data,
            let image = UIImage(data: data) {
            completion(image)
        }
    }
    
    func downloadImage(with imageURL: URL, _ completion: @escaping (UIImage) -> Void) {
        let request = URLRequest(url: imageURL)

        self.dataTask = URLSession.shared.dataTask(with: imageURL) { data, response, _ in
            if let data = data {
                let cachedData = CachedURLResponse(response: response!, data: data)
                self.cache.storeCachedResponse(cachedData, for: request)
                completion(UIImage(data: data)!)
            }
        }
        self.dataTask?.resume()
    }
}
