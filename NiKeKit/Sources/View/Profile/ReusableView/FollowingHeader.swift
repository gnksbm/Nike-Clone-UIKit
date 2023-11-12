//
//  FollowingHeader.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/12.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

class FollowingHeader: UICollectionReusableView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .bold)
        label.textColor = NikeKitAsset.accentColor.color
        return label
    }()
    
    let editBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = .systemFont(ofSize: 14, weight: .medium)
        config.baseForegroundColor = .gray
        config.attributedTitle = AttributedString("편집", attributes: titleContainer)
        let button = UIButton(configuration: config)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [titleLabel, editBtn].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            
            editBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            editBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
        ])
    }
}
