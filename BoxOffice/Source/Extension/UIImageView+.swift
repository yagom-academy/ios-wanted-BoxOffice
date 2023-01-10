//
//  UIImageView+.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/06.
//

import UIKit

extension UIImageView {
    func fetch(url: String?, completion: @escaping (Result<UIImage, Error>) -> Void) {
        guard let urlString = url,
              let url = URL(string: urlString) else {
            return
        }
        
        if let cachedImage = ImageCacheManager.shared.getCachedImage(url: NSString(string: urlString)) {
            completion(.success(cachedImage))
            return
        }

        let request = URLRequest(url: url)
        
        let urlSession = URLSession(configuration: .ephemeral)
        urlSession.dataTask(with: request) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(error!))
                return
            }
            
            guard let data = data,
                  let image = UIImage(data: data) else {
                completion(.failure(error!))
                return
            }
            
            ImageCacheManager.shared.saveCache(image: image, url: urlString)
            completion(.success(image))
        }.resume()
    }
}
