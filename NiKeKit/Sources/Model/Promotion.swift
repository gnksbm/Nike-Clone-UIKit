//
//  Promotion.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/12.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import Foundation

struct Promotion: Identifiable, Hashable {
    let id: String
    let name: String
    var code: String
    var discountRate: Double
    var expireDate: Date
    
    init(id: String = UUID().uuidString,
         name: String,
         code: String = String(UUID().uuidString.prefix(10)),
         discountRate: Double,
         expireDate: Date) {
        self.id = id
        self.name = name
        self.code = code
        self.discountRate = discountRate
        self.expireDate = expireDate
    }
}

extension Promotion {
    var description: String {
        "\(self.name) \(String(Int(self.discountRate * 100)))%"
    }
}

extension Promotion {
    static let sample1: Self = .init(name: "앱 첫 구매", discountRate: 0.15, expireDate: Date(timeInterval: 86400 * 7, since: .now))
}
