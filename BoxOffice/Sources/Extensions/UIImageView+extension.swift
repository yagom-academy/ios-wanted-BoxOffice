//
//  UIImageView+extension.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import UIKit
import OSLog

extension UIImageView {
    
    private func indicator() -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.tintColor = .white
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        return activityIndicator
    }
    
    func setImage(with url: String) {
        let indicator = indicator()
        addSubview(indicator)
        indicator.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        indicator.centerYAnchor.constraint(equalTo: self.centerYAnchor).isActive = true
        
        if let cachedImage = ImageCacheManager.shared.loadCachedData(for: url) {
            self.image = cachedImage
            indicator.stopAnimating()
        } else {
            DispatchQueue.global().async {
                guard let imageURL = URL(string: url),
                      let imageData = try? Data(contentsOf: imageURL),
                      let loadedImage = UIImage(data: imageData) else {
                    os_log(.error, log: .default, "⛔️ 이미지를 가져오는데 실패하였습니다.")
                    return
                }
                DispatchQueue.main.async {
                    ImageCacheManager.shared.setCacheData(of: loadedImage, for: url)
                    self.image = loadedImage
                    indicator.stopAnimating()
                }
            }
        }
    }
}
