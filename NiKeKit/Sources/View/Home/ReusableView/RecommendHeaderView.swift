//
//  RecommendHeaderView.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/04.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

final class RecommendHeaderView: UICollectionReusableView {
    let msgLabel: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 26, weight: .medium)
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        return label
    }()
    
    let subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        label.textColor = .darkGray
        return label
    }()
    
    let showBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .darkGray
        let btn = UIButton(configuration: config)
        btn.titleLabel?.font = .systemFont(ofSize: UIFont.labelFontSize)
        return btn
    }()
    
    let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
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
        [titleLabel, subTitleLabel].forEach {
            titleStackView.addArrangedSubview($0)
        }
        [msgLabel, titleStackView, showBtn].forEach {
            self.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            msgLabel.topAnchor.constraint(equalTo: self.topAnchor),
            msgLabel.heightAnchor.constraint(equalToConstant: .screenHeight / 8),
            msgLabel.centerXAnchor.constraint(equalTo: self.centerXAnchor),
            
            titleStackView.topAnchor.constraint(equalTo: msgLabel.bottomAnchor),
            titleStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            showBtn.topAnchor.constraint(equalTo: titleStackView.topAnchor),
            showBtn.bottomAnchor.constraint(equalTo: titleStackView.bottomAnchor),
            showBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

import SwiftUI
struct RecommendHeaderView_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 0)
    }
}
