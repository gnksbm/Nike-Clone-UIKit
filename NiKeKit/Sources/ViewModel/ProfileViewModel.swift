//
//  ProfileViewModel.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/12.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import Foundation

final class ProfileViewModel {
    private(set) var user: User = .sample1
    private(set) var products: [Product] = []
    
    private var onComplete: () -> Void = { }
    
    func product(id: String) -> Product? {
        return products.first(where: { $0.id == id })
    }
    
    func fetchProducts() {
        products = [.sample1, .sample2, .sample3, .sample4, .sample5, .sample6]
        onComplete()
    }
    
    func setOnCompleteAction(_ handler: @escaping () -> Void) {
        onComplete = handler
    }
}
