//
//  CacheManager.swift
//  Zeno
//
//  Created by gnksbm on 2023/10/31.
//  Copyright © 2023 https://github.com/gnksbm/LikeLionAppSchool. All rights reserved.
//

import Foundation

class CacheManager<T: AnyObject> {
    private let shared = NSCache<NSString, T>()

    func saveData(url: URL, data: T) {
        shared.setObject(data, forKey: url.absoluteString as NSString)
    }

    func loadData(url: URL) -> T? {
        return shared.object(forKey: url.absoluteString as NSString)
    }
}
