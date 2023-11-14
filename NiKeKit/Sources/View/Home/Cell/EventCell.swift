//
//  EventCell.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/03.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

final class EventCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()

    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .light)
        label.textColor = .darkGray
        label.numberOfLines = 2
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.layer.cornerRadius = 6
        contentView.backgroundColor = .white
        contentView.layer.shadowOpacity = 0.07
        contentView.layer.shadowRadius = 10
        contentView.layer.shadowOffset = CGSize(width: 0, height: 10)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        contentLabel.text = nil
    }
    
    func configureUI() {
        [titleLabel, contentLabel].forEach {
            stackView.addArrangedSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        [imageView, stackView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        let heightRatio = 0.8
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            imageView.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: heightRatio),
            imageView.widthAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: heightRatio),
            imageView.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            
            stackView.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 15),
            stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -25),
            stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            stackView.bottomAnchor.constraint(equalTo: imageView.bottomAnchor, constant: -5),
        ])
    }
}

import SwiftUI
struct EventCell_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 0)
    }
}
