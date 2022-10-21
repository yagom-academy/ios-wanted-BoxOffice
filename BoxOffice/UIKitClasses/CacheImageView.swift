//
//  CacheImageView.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import Foundation
import UIKit

class CacheImageView: UIImageView {

    var lastImageURLString: String?

    private let sharedHandler = CacheHandler.sharedInstance
    
    func loadImage(urlString: String) {
        
        DispatchQueue.main.async { [weak self] in
            guard let self = self else { return }
            self.image = nil
        }
        self.lastImageURLString = urlString
        if let image = sharedHandler.object(forKey: urlString) as? UIImage {
            
            DispatchQueue.main.async { [weak self] in
                guard let self = self else { return }
                self.image = image
            }
            return
        }
        Task {
            await requestImage(urlString: urlString)
        }
    }
    
    private func requestImage(urlString: String) async {
        do {
            let data = try await sharedHandler.fetch(with: urlString)
            guard let absoluteString = data.1?.absoluteString else { setErrorImage()
                return }
            guard lastImageURLString == absoluteString else { setErrorImage()
                return }
            guard let image = UIImage(data: data.0) else { setErrorImage()
                return }
            
            sharedHandler.setObject(image, forKey: absoluteString)
            DispatchQueue.main.async { [weak self] in
                self?.image = image
            }
        } catch {
            handleError(error: error)
        }
    }
    
    private func setErrorImage() {
        self.image = UIImage(systemName: .errorImage)
    }
    
    func handleError(error: Error) {
        let error = error as? HTTPError
        switch error {
        case .badURL, .badResponse, .errorDecodingData, .invalidURL, .iosDevloperIsStupid:
            setErrorImage()
        default:
            break
        }
    }
    
    func deprecated_requestImage(urlString: String) {
        self.image = nil
        self.lastImageURLString = urlString

        if let image = sharedHandler.object(forKey: urlString) as? UIImage {
            self.image = image
            return
        }
        
        guard let url = URL(string: urlString) else {
            setErrorImage()
            return }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            
            if let error = error {
                self?.handleError(error: error)
            }
            
            if self?.lastImageURLString != url.absoluteString {
                self?.setErrorImage()
                return
            }
            
            guard let data = data else { return }
            guard let image = UIImage(data: data) else { return }
            
            self?.sharedHandler.setObject(image, forKey: url.absoluteString)
            
            DispatchQueue.main.async {
                self?.image = image
            }
        }.resume()
        
    }
}
