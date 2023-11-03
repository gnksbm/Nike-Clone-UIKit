//
//  Int+.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/02.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import Foundation

extension Int {
    var toPriceStr: String {
        let numformat = NumberFormatter()
        numformat.numberStyle = .decimal
        guard let result = numformat.string(from: self as NSNumber) else { return "Error" }
        return "₩" + result
    }
}
