//
//  NSDirectionalEdgeInsets+.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/03.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

extension NSDirectionalEdgeInsets {
    static func sameEdge(value: Int) -> Self {
        Self.init(top: CGFloat(value), leading: CGFloat(value), bottom: CGFloat(value), trailing: CGFloat(value))
    }
}
