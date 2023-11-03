//
//  HomeCVHeaderView.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit

class HomeCVHeaderView: UICollectionReusableView {
    var section: HomeSection = .inspiration
    
    let msgLabel: UILabel = {
        let label = UILabel()
        label.font =  .systemFont(ofSize: 26, weight: .medium)
        return label
    }()
    
    let titlelabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
        return label
    }()
    
    let subTitlelabel: UILabel = {
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        configureUI()
    }
    
    func configureUI() {
        switch section {
        case .recommend:
            [titlelabel, subTitlelabel].forEach {
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
                
                showBtn.topAnchor.constraint(equalTo: msgLabel.bottomAnchor),
                showBtn.bottomAnchor.constraint(equalTo: self.bottomAnchor),
                showBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            ])
            return
        case .news, .inspiration:
            titleStackView.addArrangedSubview(titlelabel)
        case .relation:
            [titlelabel, subTitlelabel].forEach {
                titleStackView.addArrangedSubview($0)
            }
            titleStackView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(titleStackView)
            
            NSLayoutConstraint.activate([
                titleStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
                titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            ])
            return
        }
        
        [titleStackView, showBtn].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            titleStackView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            titleStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            
            showBtn.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            showBtn.trailingAnchor.constraint(equalTo: self.trailingAnchor),
        ])
    }
}

import SwiftUI
struct HomeCVHeaderView_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 0)
    }
}
