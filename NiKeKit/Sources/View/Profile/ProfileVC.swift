//
//  ProfileVC.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit

final class ProfileVC: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<ProfileSection, String>!
    private var snapshot: NSDiffableDataSourceSnapshot<ProfileSection, String>!
    
    private let viewModel = ProfileViewModel()
    
    private lazy var profileCV: UICollectionView = {
        let layout = makeLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.dataSource = dataSource
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
        viewModel.setOnCompleteAction(updateSnapshot)
        viewModel.fetchProducts()
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = true
        [profileCV].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            profileCV.topAnchor.constraint(equalTo: safeArea.topAnchor),
            profileCV.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            profileCV.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            profileCV.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
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
// MARK: CollectionView
extension ProfileVC {
    // MARK: Layout
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        return .init { index, _ in
            let item = NSCollectionLayoutItem(layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)))
            var group: NSCollectionLayoutGroup
            var section: NSCollectionLayoutSection
            switch ProfileSection.allCases[index] {
            case .main:
                group = .vertical(layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(0.9)
                ), subitems: [item])
                let footer = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .absolute(10)
                    ),
                    elementKind: UICollectionView.elementKindSectionFooter,
                    alignment: .bottom
                )
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(edge: .botton, value: 40)
                section.boundarySupplementaryItems = [footer]
            case .interaction:
                group = .vertical(layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1/5)
                ), subitems: [item])
                group.edgeSpacing = .init(edge: .top, spacing: .flexible(15))
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 0,
                                             leading: 20,
                                             bottom: 0,
                                             trailing: 20)
            case .following:
                group = .vertical(layoutSize: .init(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: .fractionalWidth(1/3)
                ), subitems: [item])
                group.contentInsets = .init(top: 0,
                                             leading: 0,
                                             bottom: 0,
                                             trailing: 5)
                let header = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(100)
                    ),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                header.contentInsets = .init(edge: .trailing, value: 10)
                let footer = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(50)
                    ),
                    elementKind: UICollectionView.elementKindSectionFooter,
                    alignment: .bottom
                )
                footer.contentInsets = .init(edge: .leading, value: -20)
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
                section.boundarySupplementaryItems = [header, footer]
                section.contentInsets = .init(top: 0,
                                             leading: 20,
                                             bottom: 20,
                                             trailing: 0)
            }
            return section
        }
    }
    // MARK: DataSource
    private func configureDataSource() {
        let mainReg = mainRegistration()
        let interactionReg = interactionRegistration()
        let followingReg = followingRegistration()
        
        dataSource = .init(collectionView: profileCV) { collectionView, indexPath, id in
            switch ProfileSection.allCases[indexPath.section] {
            case .main:
                return collectionView.dequeueConfiguredReusableCell(using: mainReg, for: indexPath, item: self.viewModel.user)
            case .interaction:
                let interaction = Interaction.allCases[indexPath.row]
                return collectionView.dequeueConfiguredReusableCell(using: interactionReg, for: indexPath, item: interaction)
            case .following:
                let product = self.viewModel.product(id: id)
                return collectionView.dequeueConfiguredReusableCell(using: followingReg, for: indexPath, item: product)
            }
        }
        
        let followingHeaderReg = followingHeaderRegistration()
        let footerReg = footerRegistration()
        let followingFooterReg = followingFooterRegistration()
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            switch ProfileSection.allCases[indexPath.section] {
            case .main:
                return collectionView.dequeueConfiguredReusableSupplementary(using: footerReg, for: indexPath)
            case .interaction:
                return collectionView.dequeueConfiguredReusableSupplementary(using: footerReg, for: indexPath)
            case .following:
                if kind == UICollectionView.elementKindSectionHeader {
                    return collectionView.dequeueConfiguredReusableSupplementary(using: followingHeaderReg, for: indexPath)
                } else {
                    return collectionView.dequeueConfiguredReusableSupplementary(using: followingFooterReg, for: indexPath)
                }
            }
        }
        updateSnapshot()
    }
    
    private func mainRegistration() -> UICollectionView.CellRegistration<ProfileMainCell, User> {
        return .init { cell, _, user in
            cell.profileImgBtn.setImage(user.image, for: .normal)
        }
    }
    
    private func interactionRegistration() -> UICollectionView.CellRegistration<ProfileInteractionCell, Interaction> {
        return .init { cell, _, interaction in
            cell.titleLabel.text = interaction.title
            cell.subtitleLabel.text = interaction.subtitle
            switch interaction {
            case .message:
                break
            case .memberReward:
                break
            }
        }
    }
    
    private func followingRegistration() -> UICollectionView.CellRegistration<FollowingCell, Product> {
        return .init { cell, _, product in
            if let image = product.images.first {
                cell.imageView.image = image
            }
        }
    }
    
    private func followingHeaderRegistration()
    -> UICollectionView.SupplementaryRegistration<FollowingHeader> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.titleLabel.text = "팔로잉(\(self.viewModel.products.count))"
        }
    }
    
    private func footerRegistration()
    -> UICollectionView.SupplementaryRegistration<UICollectionReusableView> {
        return .init(elementKind: UICollectionView.elementKindSectionFooter) { footer, _, _ in
            footer.backgroundColor = .systemGray6
            footer.layer.borderColor = UIColor.systemGray4.cgColor
            footer.layer.borderWidth = 1
        }
    }
    
    private func followingFooterRegistration()
    -> UICollectionView.SupplementaryRegistration<FollowingFooter> {
        return .init(elementKind: UICollectionView.elementKindSectionFooter) { footer, _, _ in
            footer.titleLabel.text = "회원 가입일: \(self.viewModel.user.joinedAt.toString)"
        }
    }
    // MARK: Snapshot
    private func updateSnapshot() {
        snapshot = .init()
        let sections = ProfileSection.allCases
        snapshot.appendSections(sections)
        sections.forEach {
            switch $0 {
            case .main:
                snapshot.appendItems(["main"], toSection: $0)
            case .interaction:
                snapshot.appendItems(Interaction.allCases.map({ $0.title }), toSection: $0)
            case .following:
                snapshot.appendItems(self.viewModel.products.map { $0.id }, toSection: $0)
            }
        }
        dataSource.apply(snapshot)
    }
}

extension ProfileVC {
    enum Interaction: CaseIterable {
        case message, memberReward
        
        var title: String {
            switch self {
            case .message:
                return "수신함"
            case .memberReward:
                return "멤버 리워드"
            }
        }
        
        var subtitle: String {
            switch self {
            case .message:
                return "메시지 보기"
            case .memberReward:
                return "1개 사용 가능"
            }
        }
    }
}

import SwiftUI
struct ProfileVC_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 4)
    }
}
