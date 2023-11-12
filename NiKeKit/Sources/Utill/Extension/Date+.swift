//
//  Date+.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/13.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import Foundation

extension Date {
    var toString: String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy년 MM월"
        let formattedStr = dateFormatter.string(from: self)
        return formattedStr
    }
}
