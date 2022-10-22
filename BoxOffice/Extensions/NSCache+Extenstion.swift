//
//  NSCache+Extenstion.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import Foundation

extension NSCache {
    @objc static var sharedCache: NSCache<AnyObject, AnyObject> {
        let cache = NSCache<AnyObject, AnyObject>()
        cache.countLimit = 0  //unlimited. default
        cache.totalCostLimit = 0 //unlimited. default
        //sharedCache.totalCostLimit = 50 * 1024 * 1024 //50mb
        return cache
    }
}
