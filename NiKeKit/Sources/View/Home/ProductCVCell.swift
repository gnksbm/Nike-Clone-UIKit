//
//  ProductCVCell.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit

class ProductCVCell: UICollectionViewCell {
    let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "progress")
        return imageView
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .light)
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
        [titleLabel, categoryLabel, priceLabel].forEach {
            stackView.addArrangedSubview($0)
        }
        [imageView, stackView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: self.topAnchor),
            imageView.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            imageView.widthAnchor.constraint(equalTo: self.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: self.heightAnchor, multiplier: 0.7),
            
            stackView.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 10),
            stackView.widthAnchor.constraint(equalTo: self.widthAnchor),
        ])
    }
}

import SwiftUI
struct ProductCVCell_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 0)
    }
}
