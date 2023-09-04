//
//  HomeCVHeaderView.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit

class HomeCVHeaderView: UICollectionReusableView {
    let sectiomTitlelabel: UILabel = {
        let label = UILabel()
        return label
    }()
    
    let allBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.title = "모두 보기"
        let btn = UIButton()
        return btn
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureUI()
    }
//
//    convenience init(title: String) {
//        self.init(frame: .zero)
//        label.text = title
//    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        [sectiomTitlelabel, allBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            sectiomTitlelabel.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            sectiomTitlelabel.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            allBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            allBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}
