//
//  Delivery.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/12.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import Foundation

enum Delivery {
    case free, normal
    
    var toString: String {
        switch self {
        case .free:
            return "표준 - 무료"
        case .normal:
            return "표준 - ₩3000"
        }
    }
    
    var value: Int {
        switch self {
        case .free:
            return 0
        case .normal:
            return 3000
        }
    }
}
