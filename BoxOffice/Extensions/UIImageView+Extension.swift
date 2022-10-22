//
//  UIImageView+Extension.swift
//  BoxOffice
//
//  Created by KangMingyo on 2022/10/20.
//

import UIKit

//Poster: "https://m.media-amazon.com/images/M/MV5BYzZkOGUwMzMtMTgyNS00YjFlLTg5NzYtZTE3Y2E5YTA5NWIyXkEyXkFqcGdeQXVyMjkwOTAyMDU@._V1_SX300.jpg")

//Poster: "https://m.media-amazon.com/images/M/MV5BZjE2ZWIwMWEtNGFlMy00ZjYzLWEzOWEtYzQ0MDAwZDRhYzNjXkEyXkFqcGdeQXVyMTUzMTg2ODkz._V1_SX300.jpg"

extension UIImageView {
    //이미지 캐싱
    func setImageUrl(url: String, movieName: String){
        let posterURL = url
        let cachedKey = NSString(string: movieName)
        
        if let cachedImage = ImageCacheManager.shared.object(forKey: cachedKey){
            self.image = cachedImage
            return
        }
        DispatchQueue.global(qos: .background).async {
            if let url = URL(string: posterURL){
                URLSession.shared.dataTask(with: url) { (data, result, error) in
                    if let _ = error {
                        DispatchQueue.main.async {
//                            self.image = UIImage()
                        }
                        return
                    }
                    DispatchQueue.main.async {
                        if let data = data, let image = UIImage(data: data){
                            ImageCacheManager.shared.setObject(image, forKey: cachedKey)
                            self.image = image
                        }
                    }
                }
                .resume()
            }
        }
    }
}
