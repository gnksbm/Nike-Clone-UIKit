//
//  StackAndShowBtnHeader.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/04.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

class StackAndShowBtnHeader: UICollectionReusableView {
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [titleLabel, subTitleLabel].forEach {
            titleStackView.addArrangedSubview($0)
        }
        titleStackView.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(titleStackView)
        
        NSLayoutConstraint.activate([
            titleStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
        ])
    }
}

import SwiftUI
struct RelationHeaderView_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 0)
    }
}
