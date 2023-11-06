//
//  LastHeaderView.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/06.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

class LastHeaderView: UICollectionReusableView {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = NikeKitAsset.nikeLogo.image
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .regular)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [imageView, titleLabel].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            imageView.bottomAnchor.constraint(equalTo: self.centerYAnchor, constant: -3),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 25),
            imageView.widthAnchor.constraint(equalToConstant: 50),
            
            titleLabel.topAnchor.constraint(equalTo: self.centerYAnchor, constant: 3),
            titleLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
        ])
    }
}

import SwiftUI
struct LastHeaderView_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 0)
    }
}
