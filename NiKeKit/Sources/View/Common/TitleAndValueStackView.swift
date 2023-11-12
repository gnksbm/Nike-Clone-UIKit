//
//  TitleAndValueStackView.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/12.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

final class TitleAndValueStackView: UIStackView {
    var foregroundColor: UIColor = NikeKitAsset.accentColor.color {
        willSet {
            setForegroundColor(newValue)
        }
    }
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.textColor = NikeKitAsset.accentColor.color
        self.addArrangedSubview(label)
        return label
    }()
    
    lazy var valueLabel: UILabel = {
        let label = UILabel()
        label.textColor = NikeKitAsset.accentColor.color
        self.addArrangedSubview(label)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [titleLabel, valueLabel].forEach {
            self.addArrangedSubview($0)
        }
        self.axis = .horizontal
        self.distribution = .equalSpacing
    }
    
    func setForegroundColor(_ color: UIColor) {
        titleLabel.textColor = color
        valueLabel.textColor = color
    }
}
