//
//  NewsCell.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/04.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

final class NewsCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "progress")
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .semibold)
        label.textColor = .white
        return label
    }()
    
    let subtitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 40, weight: .heavy)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    let interactionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    let interactionBackgroundView: UIView = {
        let label = UIView()
        label.backgroundColor = .white
        label.layer.cornerRadius = 20
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [imageView, titleLabel, subtitleLabel, interactionBackgroundView, interactionLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            interactionBackgroundView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            interactionBackgroundView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -25),
            interactionBackgroundView.widthAnchor.constraint(equalToConstant: 120),
            interactionBackgroundView.heightAnchor.constraint(equalToConstant: 40),
            
            interactionLabel.centerXAnchor.constraint(equalTo: interactionBackgroundView.centerXAnchor),
            interactionLabel.centerYAnchor.constraint(equalTo: interactionBackgroundView.centerYAnchor),

            subtitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            subtitleLabel.bottomAnchor.constraint(equalTo: interactionBackgroundView.topAnchor, constant: -20),

            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 25),
            titleLabel.bottomAnchor.constraint(equalTo: subtitleLabel.topAnchor, constant: -10),
        ])
    }
}

import SwiftUI
struct NewsCell_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 0)
    }
}
