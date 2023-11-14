//
//  SearchTrendingCell.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/09.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

final class SearchTrendingCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        let image = UIImage(systemName: "magnifyingglass")
        imageView.image = image
        imageView.tintColor = .systemGray3
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .medium)
        label.textColor = NikeKitAsset.accentColor.color
        label.numberOfLines = 1
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
    }
    
    private func configureUI() {
        [imageView, titleLabel].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.6),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            titleLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ])
    }
}

import SwiftUI
struct SearchTrendingCell_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 1)
    }
}
