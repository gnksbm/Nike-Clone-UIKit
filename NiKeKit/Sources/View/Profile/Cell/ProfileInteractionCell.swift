//
//  ProfileInteractionCell.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/12.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

class ProfileInteractionCell: UICollectionViewCell {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        label.textColor = NikeKitAsset.accentColor.color
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    let rightImgView: UIImageView = {
        let imgConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 16, weight: .medium))
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "chevron.right")
        imageView.tintColor = NikeKitAsset.accentColor.color
        imageView.preferredSymbolConfiguration = imgConfig
        return imageView
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .equalCentering
        return stackView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [titleLabel, subtitleLabel].forEach {
            labelStackView.addArrangedSubview($0)
        }
        
        [labelStackView, rightImgView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        contentView.addSubview(stackView)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
}

import SwiftUI
struct ProfileInteractionCell_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 4)
    }
}
