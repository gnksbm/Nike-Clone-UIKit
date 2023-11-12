//
//  EmptyWishListView.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/10.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

final class EmptyWishListView: UIView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 26, weight: .medium)
        label.text = "위시리스트"
        label.textColor = NikeKitAsset.accentColor.color
        return label
    }()
    
    let imageBackgroundView: UIView = {
        let view = UIView()
        view.layer.borderColor = NikeKitAsset.accentColor.color.cgColor
        view.layer.borderWidth = 1.5
        return view
    }()
    
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "heart")
        imageView.tintColor = NikeKitAsset.accentColor.color
        return imageView
    }()
    
    let messageLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 19, weight: .regular)
        label.textAlignment = .center
        label.textColor = NikeKitAsset.accentColor.color
        label.numberOfLines = 0
        label.text = "위시리스트에 추가한 상품이 없습니다."
        return label
    }()
    
    let purchaseBtn: UIButton = {
        let button = UIButton(configuration: .nikeWideBtn(title: "구매하기", fontSize: 22))
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        imageBackgroundView.layer.cornerRadius = imageBackgroundView.bounds.width / 2
    }
    
    private func configureUI() {
        self.backgroundColor = .systemBackground
        [titleLabel, imageBackgroundView, imageView, messageLabel, purchaseBtn].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let safeArea = self.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeArea.topAnchor),
            titleLabel.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 1/4),
            titleLabel.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 25),
            
            imageBackgroundView.widthAnchor.constraint(equalToConstant: 60),
            imageBackgroundView.heightAnchor.constraint(equalToConstant: 60),
            imageBackgroundView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            imageBackgroundView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            
            imageView.widthAnchor.constraint(equalToConstant: 25),
            imageView.heightAnchor.constraint(equalToConstant: 25),
            imageView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
            
            messageLabel.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.75),
            messageLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 50),
            messageLabel.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            
            purchaseBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.9),
            purchaseBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.18),
            purchaseBtn.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -25),
            purchaseBtn.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
        ])
    }
}

import SwiftUI
struct EmptyWishListView_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 2)
    }
}
