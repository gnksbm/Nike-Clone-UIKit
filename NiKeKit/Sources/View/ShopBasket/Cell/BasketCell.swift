//
//  BasketCell.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/11.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

class BasketCell: UICollectionViewCell {
    let productImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        label.textColor = NikeKitAsset.accentColor.color
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    let detailLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    let sizeLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }()
    
    let quantityBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        var imgConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 12, weight: .medium))
        var titleContainer = AttributeContainer()
        titleContainer.font = .systemFont(ofSize: 18, weight: .regular)
        config.baseForegroundColor = NikeKitAsset.accentColor.color
        config.attributedTitle = AttributedString("수량 1", attributes: titleContainer)
        let image = UIImage(systemName: "chevron.down")
        config.image = image
        config.imagePadding = 15
        config.imagePlacement = .trailing
        config.preferredSymbolConfigurationForImage = imgConfig
        config.contentInsets = .zero
        let button = UIButton(configuration: config)
        return button
    }()
    
    let discountLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        label.textColor = .gray
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    let priceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        return stackView
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    let promotionImageView: UIImageView = {
        let imgConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20))
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "tag.slash")
        imageView.tintColor = NikeKitAsset.accentColor.color
        imageView.preferredSymbolConfiguration = imgConfig
        return imageView
    }()
    
    let promotionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        label.text = "프로모션 대상이 아닌 제품"
        label.textColor = .darkGray
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
        productImageView.image = nil
        titleLabel.text = nil
        categoryLabel.text = nil
        detailLabel.text = nil
        sizeLabel.text = nil
        discountLabel.text = nil
        priceLabel.text = nil
        promotionLabel.text = nil
    }
    
    private func configureUI() {
        [titleLabel, categoryLabel, detailLabel, sizeLabel].forEach {
            infoStackView.addArrangedSubview($0)
        }
        
        [quantityBtn, discountLabel, priceLabel].forEach {
            priceStackView.addArrangedSubview($0)
        }
        
        [productImageView, infoStackView, priceStackView, promotionImageView, promotionLabel, dividerView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            productImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            productImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            productImageView.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            productImageView.heightAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.4),
            
            infoStackView.leadingAnchor.constraint(equalTo: productImageView.trailingAnchor, constant: 15),
            infoStackView.topAnchor.constraint(equalTo: productImageView.topAnchor),
            infoStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            
            priceStackView.topAnchor.constraint(equalTo: productImageView.bottomAnchor, constant: 15),
            priceStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            
            promotionImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            promotionImageView.topAnchor.constraint(equalTo: priceStackView.bottomAnchor, constant: 30),
            
            promotionLabel.leadingAnchor.constraint(equalTo: productImageView.leadingAnchor, constant: 40),
            promotionLabel.topAnchor.constraint(equalTo: priceStackView.bottomAnchor, constant: 30),
            promotionLabel.heightAnchor.constraint(equalToConstant: 20),
            
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
            dividerView.topAnchor.constraint(equalTo: promotionLabel.bottomAnchor, constant: 20),
        ])
    }
}

import SwiftUI
struct BasketCell_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 3)
    }
}
