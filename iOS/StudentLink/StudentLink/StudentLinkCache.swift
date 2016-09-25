//
//  StudentLinkCache.swift
//  StudentLink
//
//  Created by Danny on 9/25/16.
//  Copyright © 2016 StudentLink. All rights reserved.
//

import UIKit

class StudentLinkCache {
    static let cache: NSCache = {
        let cache = NSCache()
        cache.name = "StudentLinkCache"
        cache.countLimit = 40
        cache.totalCostLimit = 20 * 1024 * 1024
        return cache
    }()
}