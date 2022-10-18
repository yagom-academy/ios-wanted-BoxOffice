//
//  CacheHandler.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import Foundation

class CacheHandler: ImageCacheable {
    
    static let sharedInstance = CacheHandler()
    private var sharedCache = NSCache<AnyObject, AnyObject>.sharedCache

    private init() {
        
    }
    
    func setObject(_ obj : AnyObject, forKey: String) {
        sharedCache.setObject(obj, forKey: forKey as NSString)
    }
    
    func object(forKey: String) -> AnyObject? {
        return sharedCache.object(forKey: forKey as NSString)
    }
}

protocol ImageCacheable {
    
}

extension ImageCacheable where Self: CacheHandler {
    
    func fetch(with urlString: String) async throws -> (Data, URL?) {
        guard let url = URL(string: urlString) else { throw HTTPError.badURL }
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard (response as? HTTPURLResponse)?.statusCode == 200 else {
            throw HTTPError.badResponse
        }

        return (data, response.url)
    }
}
