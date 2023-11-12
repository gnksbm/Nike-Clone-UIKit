//
//  BasketFooterView.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/12.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

final class BasketFooterView: UICollectionReusableView {
    let promotionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textColor = NikeKitAsset.accentColor.color
        return label
    }()
    
    let promotionBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        let imgConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 10, weight: .medium))
        let image = UIImage(systemName: "plus")
        var titleContainer = AttributeContainer()
        titleContainer.font = .systemFont(ofSize: 14, weight: .medium)
        config.attributedTitle = AttributedString("", attributes: titleContainer)
        config.imagePlacement = .trailing
        config.image = image
        config.preferredSymbolConfigurationForImage = imgConfig
        config.imagePadding = 5
        config.baseForegroundColor = .systemGreen
        config.imageColorTransformer = UIConfigurationColorTransformer({ _ in
            NikeKitAsset.accentColor.color
        })
        config.contentInsets = .zero
        let button = UIButton(configuration: config)
        button.setPreferredSymbolConfiguration(imgConfig, forImageIn: .normal)
        return button
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 5
        stackView.axis = .vertical
        return stackView
    }()
    
    let priceView: TitleAndValueStackView = {
        let sv = TitleAndValueStackView()
        return sv
    }()
    
    let discountView: TitleAndValueStackView = {
        let sv = TitleAndValueStackView()
        return sv
    }()
    
    let deliveryView: TitleAndValueStackView = {
        let sv = TitleAndValueStackView()
        return sv
    }()
    
    let totalPriceView: TitleAndValueStackView = {
        let sv = TitleAndValueStackView()
        return sv
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        [priceView, discountView, deliveryView, totalPriceView].forEach {
            stackView.addArrangedSubview($0)
        }
        
        [promotionLabel, promotionBtn, dividerView, stackView].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            promotionLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            promotionLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            
            promotionBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            promotionBtn.centerYAnchor.constraint(equalTo: promotionLabel.centerYAnchor),
            promotionBtn.heightAnchor.constraint(equalToConstant: 10),
            
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.widthAnchor.constraint(equalTo: self.widthAnchor),
            dividerView.topAnchor.constraint(equalTo: promotionLabel.bottomAnchor, constant: 20),
            
            stackView.topAnchor.constraint(equalTo: dividerView.bottomAnchor, constant: 20),
            stackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -20)
        ])
    }
}

import SwiftUI
struct BasketFooterView_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 3)
    }
}
