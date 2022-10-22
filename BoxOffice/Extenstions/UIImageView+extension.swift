//
//  UIImageView+extension.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/19.
//

import UIKit

class ImageCacheManager {
    
    static let shared = NSCache<NSString, UIImage>()
    
    private init() {}
}

extension UIImageView {
    
    func setImageUrl(_ url: String) {
            
            let cacheKey = NSString(string: url) // 캐시에 사용될 Key 값
            
            if let cachedImage = ImageCacheManager.shared.object(forKey: cacheKey) { // 해당 Key 에 캐시이미지가 저장되어 있으면 이미지를 사용
                self.image = cachedImage
                return
            }
            
        DispatchQueue.main.async {
                if let imageUrl = URL(string: url) {
                    URLSession.shared.dataTask(with: imageUrl) { (data, res, err) in
                        if let _ = err {
                            DispatchQueue.main.async {
                                self.image = UIImage()
                            }
                            return
                        }
                        DispatchQueue.main.async {
                            if let data = data, let image = UIImage(data: data) {
                                ImageCacheManager.shared.setObject(image, forKey: cacheKey) // 다운로드된 이미지를 캐시에 저장
                                self.image = image
                            }
                        }
                    }.resume()
                }
            }
        }
 }
