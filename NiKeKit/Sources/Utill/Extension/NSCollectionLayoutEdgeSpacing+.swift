//
//  NSCollectionLayoutEdgeSpacing+.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/12.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

extension NSCollectionLayoutEdgeSpacing {
    convenience init(edge: Edge, spacing: NSCollectionLayoutSpacing?) {
        switch edge {
        case .leading:
            self.init(leading: spacing, top: nil, trailing: nil, bottom: nil)
        case .top:
            self.init(leading: nil, top: spacing, trailing: nil, bottom: nil)
        case .trailing:
            self.init(leading: nil, top: nil, trailing: spacing, bottom: nil)
        case .botton:
            self.init(leading: nil, top: nil, trailing: nil, bottom: spacing)
        }
    }
    
    enum Edge {
        case leading, top, trailing, botton
    }
}
