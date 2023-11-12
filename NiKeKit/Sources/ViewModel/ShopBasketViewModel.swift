//
//  ShopBasketViewModel.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/11.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import Foundation

final class ShopBasketViewModel {
    private(set) var basketItem: [BasketItem] = []
    private(set) var promotion: Promotion?
    private(set) var delivery: Delivery = .free
    
    var totalPrice: Int {
        basketItem
            .map { $0.product.price }
            .reduce(0, { $0 + $1 })
    }
    
    var discountPrice: Int {
        let promotions: Int = basketItem
            .compactMap { item in
                guard let discountRate = item.product.promotion?.discountRate else { return nil }
                return Int(Double(item.product.price) * discountRate)
            }
            .reduce(0, { $0 + $1 })
        return promotions
    }
    
    var accountOfPayment: Int {
        return totalPrice - discountPrice + delivery.value
    }
    
    private var onComplete: () -> Void = { }
    
    func fetchProducts() {
        basketItem = [
            .sample1,
            .sample2,
            .sample3,
            .sample4,
        ]
        promotion = .sample1
        delivery = .normal
        onComplete()
    }
    
    func setOnCompleteAction(_ handler: @escaping () -> Void) {
        onComplete = handler
    }
}
