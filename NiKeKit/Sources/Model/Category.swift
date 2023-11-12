//
//  Category.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import Foundation

enum Category: Hashable {
    case shoes(size: [ShoesSize])
    
    var toString: String {
        switch self {
        case .shoes:
            return "신발"
        }
    }
    
    var size: [ShoesSize] {
        self.size
    }
}

enum ShoesSize: Hashable {
    case s225(stock: Int),
         s230(stock: Int),
         s235(stock: Int),
         s240(stock: Int),
         s245(stock: Int),
         s250(stock: Int),
         s255(stock: Int),
         s260(stock: Int),
         s270(stock: Int),
         s275(stock: Int),
         s280(stock: Int),
         s285(stock: Int),
         s290(stock: Int),
         s295(stock: Int),
         s300(stock: Int)
    
    var toString: String {
        switch self {
        case .s225:
            return "225"
        case .s230:
            return "230"
        case .s235:
            return "235"
        case .s240:
            return "240"
        case .s245:
            return "245"
        case .s250:
            return "250"
        case .s255:
            return "255"
        case .s260:
            return "260"
        case .s270:
            return "270"
        case .s275:
            return "275"
        case .s280:
            return "280"
        case .s285:
            return "285"
        case .s290:
            return "290"
        case .s295:
            return "295"
        case .s300:
            return "300"
        }
    }
}
