//
//  NSDirectionalEdgeInsets+.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/03.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

extension NSDirectionalEdgeInsets {
    static func sameInset(_ value: Int) -> Self {
        Self.init(top: CGFloat(value), leading: CGFloat(value), bottom: CGFloat(value), trailing: CGFloat(value))
    }
    
    init(edge: Edge, value: Int) {
        switch edge {
        case .leading:
            self.init(top: 0, leading: CGFloat(value), bottom: 0, trailing: 0)
        case .top:
            self.init(top: CGFloat(value), leading: 0, bottom: 0, trailing: 0)
        case .trailing:
            self.init(top: 0, leading: 0, bottom: 0, trailing: CGFloat(value))
        case .botton:
            self.init(top: 0, leading: 0, bottom: CGFloat(value), trailing: 0)
        }
    }
    
    enum Edge {
        case leading, top, trailing, botton
    }
}
