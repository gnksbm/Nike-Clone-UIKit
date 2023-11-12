//
//  StackAndShowBtnHeader.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/09.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

final class StackAndShowBtnHeader: UICollectionReusableView {
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
    
    let titleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.spacing = 10
        stackView.axis = .vertical
        return stackView
    }()
    
    let showBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .darkGray
        let btn = UIButton(configuration: config)
        btn.titleLabel?.font = .systemFont(ofSize: UIFont.labelFontSize)
        return btn
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
        
        [titleStackView, showBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            showBtn.topAnchor.constraint(equalTo: titleStackView.topAnchor),
            showBtn.bottomAnchor.constraint(equalTo: titleStackView.bottomAnchor),
            showBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

import SwiftUI
struct StackAndShowBtnHeader_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 0)
    }
}
