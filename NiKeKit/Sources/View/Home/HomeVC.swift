//
//  HomeVC.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit
protocol HomeCell: Hashable, Sendable { }

class HomeVC: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<HomeSection, String>!
    private var snapshot: NSDiffableDataSourceSnapshot<HomeSection, String>!
    
    private let viewModel = HomeViewModel()
    
    private lazy var searchBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = UIColor(named: NikeKitAsset.accentColor.name)
        config.image = UIImage(systemName: "magnifyingglass")
        let btn = UIButton(configuration: config)
        return btn
    }()
    
    private lazy var collectionView: UICollectionView = {
        let compositionalLayout = makeLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: compositionalLayout)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
        viewModel.setOnCompleteAction(updateSnapshot)
        viewModel.fetchProducts()
    }
    
    private func setNavigation() {
        let searchItem = UIBarButtonItem(systemItem: .search)
        searchItem.tintColor = UIColor(named: NikeKitAsset.accentColor.name)
        navigationItem.rightBarButtonItem = searchItem
    }
    
    private func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = true
        [searchBtn, collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            searchBtn.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            
            collectionView.topAnchor.constraint(equalTo: searchBtn.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        view.setNeedsUpdateConstraints()
    }
}

extension HomeVC {
    private func makeProductLayout() -> UICollectionViewCompositionalLayout {
        return .init { index, _ in
            let sectionKind = HomeSection.allCases[index]
            
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(0.4),
                    heightDimension: .estimated(.screenHeight / 2.8)
                ), subitems: [item]
            )
            group.contentInsets = .sameInset(5)
            let section = NSCollectionLayoutSection(group: group)
            let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(50)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            headerSupplementary.contentInsets = .init(top: 20, leading: 5, bottom: 20, trailing: 10)
            section.boundarySupplementaryItems.append(headerSupplementary)
            section.contentInsets = .init(top: 20, leading: 20, bottom: 0, trailing: 0)
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
    }
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        return .init { index, _ in
            let sectionKind = HomeSection.allCases[index]
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            var group: NSCollectionLayoutGroup
            var section: NSCollectionLayoutSection
            switch sectionKind {
            case .recommend, .relation:
                group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(0.4),
                        heightDimension: .estimated(.screenHeight / 2.8)
                    ), subitems: [item]
                )
                group.contentInsets = .sameInset(5)
                section = NSCollectionLayoutSection(group: group)
                section.contentInsets = .init(top: 20, leading: 20, bottom: 0, trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
            case .event:
                item.contentInsets = .sameInset(5)
                group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(0.9),
                        heightDimension: .estimated(.screenHeight / 6)
                    ), subitems: [item]
                )
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = .init(top: .screenWidth / 6,
                                              leading: .screenWidth / 20,
                                              bottom: .screenWidth / 10,
                                              trailing: .screenWidth / 20)
            case .news:
                group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(0.4),
                        heightDimension: .estimated(.screenHeight / 2.8)
                    ), subitems: [item]
                )
                group.contentInsets = .sameInset(5)
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            case .inspiration:
                group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(0.4),
                        heightDimension: .estimated(.screenHeight / 2.8)
                    ), subitems: [item]
                )
                section = NSCollectionLayoutSection(group: group)
                section.orthogonalScrollingBehavior = .continuous
            }
            if sectionKind != .event {
                let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(50)
                    ),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                headerSupplementary.contentInsets = .init(top: 20, leading: 5, bottom: 20, trailing: 10)
                section.boundarySupplementaryItems.append(headerSupplementary)
            }
            return section
        }
    }
    
    private func configureDataSource() {
        let productConfig = productCVCellRegistration()
        let eventConfig = eventCVCellRegistration()
        dataSource = .init(collectionView: collectionView) { collectionView, indexPath, id in
            switch HomeSection.allCases[indexPath.section] {
            case .recommend, .relation:
                let cell = collectionView.dequeueConfiguredReusableCell(using: productConfig, for: indexPath, item: id)
                return cell
            case .event:
                let cell = collectionView.dequeueConfiguredReusableCell(using: eventConfig, for: indexPath, item: id)
                return cell
            case .news:
                let cell = collectionView.dequeueConfiguredReusableCell(using: productConfig, for: indexPath, item: id)
                return cell
            case .inspiration:
                let cell = collectionView.dequeueConfiguredReusableCell(using: productConfig, for: indexPath, item: id)
                return cell
            }
        }
        let headerRegistration = UICollectionView.SupplementaryRegistration<HomeCVHeaderView>.init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            let sectionKind = HomeSection.allCases[indexPath.section]
            header.section = sectionKind
            header.configureUI()
            header.msgLabel.text = self.viewModel.titleMessage
            header.titleLabel.text = sectionKind.header.title
            if let subtitle = sectionKind.header.subTitle {
                header.subTitleLabel.text = subtitle
            }
            header.showBtn.setTitle("모두 보기", for: .normal)
        }
        dataSource.supplementaryViewProvider = { _, _, indexPath in
            return self.collectionView.dequeueConfiguredReusableSupplementary(using: headerRegistration, for: indexPath)
        }
        updateSnapshot()
    }
    
    private func productCVCellRegistration() -> UICollectionView.CellRegistration<ProductCVCell, String> {
        return .init { cell, _, id in
            let product = self.viewModel.products.first(where: { $0.id == id })
            if let image = product?.images.first {
                cell.imageView.image = image
            }
            cell.titleLabel.text = product?.productName
            cell.categoryLabel.text = product?.category.toString
            cell.priceLabel.text = product?.price.toPriceStr
        }
    }
    
    private func eventCVCellRegistration() -> UICollectionView.CellRegistration<EventCVCell, String> {
        return .init { cell, _, id in
            let event = self.viewModel.events.first(where: { $0.id == id })
                cell.imageView.image = event?.image
            cell.titleLabel.text = event?.title
            cell.contentLabel.text = event?.content
        }
    }
    
    private func updateSnapshot() {
        snapshot = .init()
        let section = HomeSection.allCases
        snapshot.appendSections(section)
        section.forEach {
            switch $0 {
            case .recommend:
                snapshot.appendItems(self.viewModel.recommendedProducts.map({ $0.id }), toSection: $0)
            case .event:
                snapshot.appendItems(self.viewModel.events.map({ $0.id }), toSection: $0)
            case .news:
                break
            case .relation:
                snapshot.appendItems(self.viewModel.relationProducts.map({ $0.id }), toSection: $0)
            case .inspiration:
                break
            }
        }
        dataSource.apply(snapshot)
    }
}

import SwiftUI
struct HomeVC_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 0)
    }
}
