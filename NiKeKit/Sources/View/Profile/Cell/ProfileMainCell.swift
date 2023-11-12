//
//  ProfileMainCell.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/12.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

class ProfileMainCell: UICollectionViewCell {
    let profileImgBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        let imgConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 50))
        let image = UIImage(systemName: "person.fill")
        config.image = image
        config.imagePadding = .zero
        config.background.backgroundColor = .gray
        config.baseForegroundColor = .systemBackground
        config.cornerStyle = .capsule
        config.preferredSymbolConfigurationForImage = imgConfig
        let button = UIButton(configuration: config)
        button.clipsToBounds = true
        return button
    }()

    let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textColor = NikeKitAsset.accentColor.color
        return label
    }()

    let profileEditBtn: UIButton = {
        var config = UIButton.Configuration.filled()
        var attributeContainer = AttributeContainer()
        attributeContainer.font = .systemFont(ofSize: 16, weight: .light)
        config.title = "프로필 수정"
        config.attributedTitle = AttributedString("프로필 수정", attributes: attributeContainer)
        config.background.backgroundColor = .systemBackground
        config.baseForegroundColor = NikeKitAsset.accentColor.color
        config.contentInsets = .sameInset(10)
        let button = UIButton(configuration: config)
        button.clipsToBounds = true
        button.layer.borderColor = UIColor.systemGray4.cgColor
        button.layer.borderWidth = 1
        return button
    }()

    let iconStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
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
        contentView.backgroundColor = .systemBackground
        setIconBtn()
        iconStackView.addDivider(color: .systemGray4)
        [profileImgBtn, nameLabel, profileEditBtn, iconStackView].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            profileImgBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileImgBtn.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 40),
            
            nameLabel.topAnchor.constraint(equalTo: profileImgBtn.bottomAnchor, constant: 40),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            
            profileEditBtn.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 40),
            profileEditBtn.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            profileEditBtn.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5),
            
            iconStackView.topAnchor.constraint(equalTo: profileEditBtn.bottomAnchor, constant: 40),
            iconStackView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            iconStackView.widthAnchor.constraint(equalTo: contentView.widthAnchor),
        ])
    }
    
    private func setIconBtn() {
        IconBtn.allCases.forEach {
            let config = getProfileBtnConfig(image: $0.image, title: $0.title)
            let button = UIButton(configuration: config)
            button.tag = $0.rawValue
            iconStackView.addArrangedSubview(button)
        }
    }
    
    private func getProfileBtnConfig(image: UIImage?, title: String) -> UIButton.Configuration {
        var config = UIButton.Configuration.plain()
        let imgConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: 20))
        let image = image
        config.image = image
        config.imageColorTransformer = .init { _ in
                .systemGray2
        }
        config.imagePadding = 15
        config.imagePlacement = .top
        config.preferredSymbolConfigurationForImage = imgConfig
        var titleContainer = AttributeContainer()
        titleContainer.font = .systemFont(ofSize: 14, weight: .light)
        titleContainer.foregroundColor = NikeKitAsset.accentColor.color
        config.attributedTitle = AttributedString(title, attributes: titleContainer)
        return config
    }
}

extension ProfileMainCell {
    enum IconBtn: Int, CaseIterable {
        case order, pass, event, setting
        
        var title: String {
            switch self {
            case .order:
                return "주문"
            case .pass:
                return "패스"
            case .event:
                return "이벤트"
            case .setting:
                return "설정"
            }
        }
        
        var image: UIImage? {
            switch self {
            case .order:
                return UIImage(systemName: "archivebox.fill")
            case .pass:
                return UIImage(systemName: "person.crop.square.filled.and.at.rectangle")
            case .event:
                return UIImage(systemName: "calendar")
            case .setting:
                return UIImage(systemName: "gearshape")
            }
        }
    }
}

import SwiftUI
struct ProfileMainCell_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 4)
    }
}
