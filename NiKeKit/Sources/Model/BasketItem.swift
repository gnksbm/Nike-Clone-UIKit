//
//  BasketItem.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/11.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

struct BasketItem: Hashable {
    let id: String
    let product: Product
    var count: Int
    
    init(id: String = UUID().uuidString,
         product: Product,
         count: Int) {
        self.id = id
        self.product = product
        self.count = count
    }
}

extension BasketItem {
    static let sample1: Self = .init(product: .sample1, count: 1)
    static let sample2: Self = .init(product: .sample2, count: 2)
    static let sample3: Self = .init(product: .sample3, count: 3)
    static let sample4: Self = .init(product: .sample4, count: 4)
}
