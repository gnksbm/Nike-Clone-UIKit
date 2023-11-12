//
//  TitleAndShowBtnHeader.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit

final class TitleAndShowBtnHeader: UICollectionReusableView {
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        return label
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
        [titleLabel, showBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            showBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            showBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

import SwiftUI
struct TitleAndShowBtnView_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 0)
    }
}
