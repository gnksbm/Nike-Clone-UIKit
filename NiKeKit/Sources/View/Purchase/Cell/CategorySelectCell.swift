//
//  CategorySelectCell.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/08.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

final class CategorySelectCell: UICollectionViewCell {
    let label: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        label.textColor = .darkGray
        label.textAlignment = .center
        return label
    }()
    
    let underLineView: UIView = {
        let view = UIView()
        view.backgroundColor = NikeKitAsset.accentColor.color
        return view
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
        configureUI()
    }
    
    private func configureUI() {
        [label, underLineView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            label.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            label.heightAnchor.constraint(equalTo: contentView.heightAnchor),
            
            underLineView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            underLineView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            underLineView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 2/3),
            underLineView.heightAnchor.constraint(equalToConstant: 2),
        ])
    }
}

import SwiftUI
struct CategorySelectCell_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 1)
    }
}
