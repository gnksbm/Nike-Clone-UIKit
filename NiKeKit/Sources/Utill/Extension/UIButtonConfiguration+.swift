//
//  UIButtonConfiguration+.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/11.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

extension UIButton.Configuration {
    static func nikeWideBtn(title: String, fontSize: CGFloat) -> Self {
        var config = UIButton.Configuration.filled()
        var titleContainer = AttributeContainer()
        titleContainer.font = .systemFont(ofSize: fontSize, weight: .bold)
        titleContainer.foregroundColor = .systemBackground
        config.attributedTitle = AttributedString(title, attributes: titleContainer)
        config.cornerStyle = .capsule
        config.background.backgroundColor = NikeKitAsset.accentColor.color
        return config
    }
}
