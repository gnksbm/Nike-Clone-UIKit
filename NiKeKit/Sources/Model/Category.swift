//
//  Category.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import Foundation

enum Category: Hashable {
    case shoes(size: [ShoesSize])
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
}
