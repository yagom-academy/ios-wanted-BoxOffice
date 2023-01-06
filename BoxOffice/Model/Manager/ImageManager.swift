//
//  ImageManager.swift
//  BoxOffice
//
//  Created by 박도원 on 2023/01/04.
//

import Foundation
import UIKit

class ImageManager {
    static func loadImage(from url: String, completion: @escaping (UIImage?) -> ()) {
        if url.isEmpty {
            completion(nil)
            return
        }
        
        guard let imageURL = URL(string: url) else {
            return
        }
        
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: imageURL),
               let image = UIImage(data: data) {
                DispatchQueue.main.async {
                    completion(image)
                }
            } else {
                DispatchQueue.main.async {
                    completion(nil)
                }
            }
        }
    }
}
