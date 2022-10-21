//
//  ImageManager.swift
//  BoxOffice
//
//  Created by sole on 2022/10/22.
//

import UIKit

final class ImageManager {
    static private let cachedImage = NSCache<NSString, UIImage>()
    
    static func fetchImage(_ path: String) async throws -> UIImage {
        let cachedKey = NSString(string: path)
        guard let image = cachedImage.object(forKey: cachedKey) else {
            let iconUrlString = URLManager.tmdbImageURL + path
        
            guard let iconUrl = URL(string: iconUrlString),
                  let iconData = try? Data(contentsOf: iconUrl),
                  let icon = UIImage(data: iconData) else {
                throw ImageError.failToLoad
            }
            cachedImage.setObject(icon, forKey: cachedKey)
           return icon
        }
        return image 
    }
}
