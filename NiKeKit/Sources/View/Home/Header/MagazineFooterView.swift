//
//  MagazineFooterView.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/05.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

class MagazineFooterView: UICollectionReusableView {
    let showBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = .white
        config.titleAlignment = .center
        config.cornerStyle = .capsule
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
    
    func configureUI() {
        showBtn.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(showBtn)
        
        NSLayoutConstraint.activate([
            showBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            showBtn.widthAnchor.constraint(equalTo: self.widthAnchor, multiplier: 0.9),
            showBtn.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
}

import SwiftUI
struct MagazineFooterView_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 0)
    }
}
