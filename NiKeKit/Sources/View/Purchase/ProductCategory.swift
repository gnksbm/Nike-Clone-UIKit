//
//  ProductCategory.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/08.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import Foundation

enum ProductCategory: Int, CaseIterable {
    case man, wonam, kids, jordan
    
    var toString: String {
        switch self {
        case .man:
            return "남성"
        case .wonam:
            return "여성"
        case .kids:
            return "키즈"
        case .jordan:
            return "조던"
        }
    }
}
