//
//  HomeVC.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit

final class HomeVC: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<HomeSection, String>!
    private var snapshot: NSDiffableDataSourceSnapshot<HomeSection, String>!
    
    private let viewModel = HomeViewModel()
    
    private lazy var searchBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        let imgConfig = UIImage.SymbolConfiguration(font: .systemFont(ofSize: UIFont.buttonFontSize, weight: .medium))
        config.preferredSymbolConfigurationForImage = imgConfig
        config.baseForegroundColor = NikeKitAsset.accentColor.color
        config.image = UIImage(systemName: "magnifyingglass")
        config.buttonSize = .mini
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
        searchItem.tintColor = NikeKitAsset.accentColor.color
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
            searchBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -5),
            
            collectionView.topAnchor.constraint(equalTo: searchBtn.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
        view.setNeedsUpdateConstraints()
    }
}
// MARK: CollectionView
extension HomeVC {
    // MARK: Layout
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { index, _ in
            let sectionKind = HomeSection.allCases[index]
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            var group: NSCollectionLayoutGroup
            var section: NSCollectionLayoutSection
            var headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(100)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            switch sectionKind {
            case .recommend, .relation:
                group = .horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(0.4),
                        heightDimension: .fractionalWidth(0.6)
                    ), subitems: [item]
                )
                group.contentInsets = .sameInset(5)
                section = .init(group: group)
                section.contentInsets = .init(top: 20,
                                              leading: 15,
                                              bottom: 130,
                                              trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
                headerSupplementary.contentInsets = .init(top: 20,
                                                          leading: 5,
                                                          bottom: 20,
                                                          trailing: 10)
            case .event:
                item.contentInsets = .sameInset(5)
                group = .horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(0.9),
                        heightDimension: .estimated(.screenHeight / 6)
                    ), subitems: [item]
                )
                section = .init(group: group)
                section.orthogonalScrollingBehavior = .groupPaging
                section.contentInsets = .init(top: 0,
                                              leading: .screenWidth / 20,
                                              bottom: .screenWidth / 10,
                                              trailing: .screenWidth / 20)
            case .news:
                group = .horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalWidth(1.4)
                    ), subitems: [item]
                )
                group.contentInsets = .init(top: 5, leading: 0, bottom: 0, trailing: 0)
                section = .init(group: group)
                headerSupplementary.contentInsets = .init(top: 40,
                                                          leading: 20,
                                                          bottom: 20,
                                                          trailing: 10)
            case .magazine:
                let halfItem = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1/2),
                        heightDimension: .fractionalWidth(1.45)
                    )
                )
                halfItem.contentInsets = .init(top: 0,
                                              leading: .screenWidth/30,
                                              bottom: 0,
                                              trailing: 0)
                let hGroup = NSCollectionLayoutGroup.horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalWidth(0.95)
                    ), subitems: [halfItem]
                )
                hGroup.contentInsets = .init(top: 0,
                                              leading: .screenWidth/30,
                                              bottom: 0,
                                              trailing: .screenWidth/15)
                group = .vertical(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalWidth(1.45)
                    ), subitems: [item]
                )
                group.contentInsets = .init(top: 0,
                                              leading: .screenWidth/15,
                                              bottom: 0,
                                              trailing: .screenWidth/15)
                let totalGroup = NSCollectionLayoutGroup.vertical(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(0)
                    ), subitems: [group, hGroup]
                )
                section = .init(group: totalGroup)
                headerSupplementary.contentInsets = .init(top: 40,
                                                          leading: 20,
                                                          bottom: 20,
                                                          trailing: 10)
                let decorationView = NSCollectionLayoutDecorationItem.background(elementKind: AccentBackgroundView.identifier)
                section.decorationItems = [decorationView]
                let footerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(100)
                    ),
                    elementKind: UICollectionView.elementKindSectionFooter,
                    alignment: .bottom
                )
                section.boundarySupplementaryItems.append(footerSupplementary)
            case .last:
                group = .horizontal(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(0),
                        heightDimension: .fractionalWidth(0)
                    ), subitems: [item]
                )
//                group.contentInsets = .init(top: 5, leading: 0, bottom: 0, trailing: 0)
                headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(200)
                    ),
                    elementKind: UICollectionView.elementKindSectionHeader,
                    alignment: .top
                )
                section = .init(group: group)
            }
            if sectionKind != .event {
                section.boundarySupplementaryItems.append(headerSupplementary)
            }
            return section
        }
        layout.register(AccentBackgroundView.self, forDecorationViewOfKind: AccentBackgroundView.identifier)
        return layout
    }
    // MARK: DataSource
    private func configureDataSource() {
        let productReg = productRegistration()
        let eventReg = eventRegistration()
        let newsReg = newsRegistration()
        let magazineReg = magazineRegistration()
        
        dataSource = .init(collectionView: collectionView) { collectionView, indexPath, id in
            switch HomeSection.allCases[indexPath.section] {
            case .recommend, .relation:
                let product = self.viewModel.product(id: id)
                return collectionView.dequeueConfiguredReusableCell(using: productReg, for: indexPath, item: product)
            case .event:
                let event = self.viewModel.event(id: id)
                return collectionView.dequeueConfiguredReusableCell(using: eventReg, for: indexPath, item: event)
            case .news:
                let news = self.viewModel.news(id: id)
                return collectionView.dequeueConfiguredReusableCell(using: newsReg, for: indexPath, item: news)
            case .magazine:
                let magazine = self.viewModel.magazine(id: id)
                return collectionView.dequeueConfiguredReusableCell(using: magazineReg, for: indexPath, item: magazine)
            case .last:
                let magazine = self.viewModel.magazine(id: id)
                let cell = collectionView.dequeueConfiguredReusableCell(using: magazineReg, for: indexPath, item: magazine)
                return cell
            }
        }
        let homeHeaderReg = homeHeaderRegistration()
        let recommendHeaderReg = recommendHeaderRegistration()
        let relationHeaderReg = relationHeaderRegistration()
        let magazineHeaderReg = magazineHeaderRegistration()
        let magazineFooterReg = magazineFooterRegistration()
        let lastHeaderReg = lastHeaderRegistration()
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            let sectionKind = HomeSection.allCases[indexPath.section]
            switch sectionKind {
            case .recommend:
                return collectionView.dequeueConfiguredReusableSupplementary(using: recommendHeaderReg, for: indexPath)
            case .relation:
                return collectionView.dequeueConfiguredReusableSupplementary(using: relationHeaderReg, for: indexPath)
            case .magazine:
                if kind == UICollectionView.elementKindSectionHeader {
                    return collectionView.dequeueConfiguredReusableSupplementary(using: magazineHeaderReg, for: indexPath)
                } else {
                    return collectionView.dequeueConfiguredReusableSupplementary(using: magazineFooterReg, for: indexPath)
                }
            case .last:
                return collectionView.dequeueConfiguredReusableSupplementary(using: lastHeaderReg, for: indexPath)
            default:
                return collectionView.dequeueConfiguredReusableSupplementary(using: homeHeaderReg, for: indexPath)
            }
        }
        updateSnapshot()
    }
    
    private func productRegistration() -> UICollectionView.CellRegistration<HomeProductCell, Product> {
        return .init { cell, _, product in
            if let image = product.images.first {
                cell.imageView.image = image
            }
            cell.titleLabel.text = product.name
            cell.categoryLabel.text = product.category.toString
            cell.priceLabel.text = product.price.toPriceStr
        }
    }
    
    private func eventRegistration() -> UICollectionView.CellRegistration<EventCell, Event> {
        return .init { cell, _, event in
            cell.imageView.image = event.image
            cell.titleLabel.text = event.title
            cell.contentLabel.text = event.content
        }
    }
    
    private func newsRegistration() -> UICollectionView.CellRegistration<NewsCell, News> {
        return .init { cell, _, news in
            cell.imageView.image = news.image
            cell.titleLabel.text = news.title
            cell.subtitleLabel.text = news.subtitle
            cell.interactionLabel.text = news.interaction
        }
    }
    
    private func magazineRegistration() -> UICollectionView.CellRegistration<MagazineCell, Magazine> {
        return .init { cell, _, magazine in
            cell.imageView.image = magazine.image
            cell.authorLabel.text = magazine.author
            cell.titleLabel.text = magazine.title
        }
    }
    
    private func homeHeaderRegistration() -> UICollectionView.SupplementaryRegistration<TitleAndShowBtnHeader> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            let sectionKind = HomeSection.allCases[indexPath.section]
            header.titleLabel.text = sectionKind.header.title
            header.showBtn.setTitle("모두 보기", for: .normal)
            if sectionKind == .magazine {
                header.titleLabel.textColor = .white
            }
        }
    }
    
    private func relationHeaderRegistration() -> UICollectionView.SupplementaryRegistration<TitleAndSubtitleBtnHeader> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            let sectionKind = HomeSection.allCases[indexPath.section]
            header.titleLabel.text = sectionKind.header.title
            header.subTitleLabel.text = sectionKind.header.subtitle
        }
    }
    
    private func recommendHeaderRegistration() -> UICollectionView.SupplementaryRegistration<RecommendHeaderView> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            let sectionKind = HomeSection.allCases[indexPath.section]
            header.msgLabel.text = self.viewModel.titleMessage
            header.titleLabel.text = sectionKind.header.title
            header.subTitleLabel.text = sectionKind.header.subtitle
            header.showBtn.setTitle("모두 보기", for: .normal)
        }
    }
    
    private func magazineHeaderRegistration() -> UICollectionView.SupplementaryRegistration<TitleAndShowBtnHeader> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            let sectionKind = HomeSection.allCases[indexPath.section]
            header.titleLabel.text = sectionKind.header.title
            header.showBtn.setTitle("모두 보기", for: .normal)
            header.titleLabel.textColor = .systemBackground
        }
    }
    
    private func magazineFooterRegistration() -> UICollectionView.SupplementaryRegistration<MagazineFooterView> {
        return .init(elementKind: UICollectionView.elementKindSectionFooter) { footer, _, _ in
            footer.showBtn.setTitle("모두 보기", for: .normal)
        }
    }
    
    private func lastHeaderRegistration() -> UICollectionView.SupplementaryRegistration<LastHeaderView> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            let sectionKind = HomeSection.allCases[indexPath.section]
            header.titleLabel.text = sectionKind.header.title
        }
    }
    // MARK: Snapshot
    private func updateSnapshot() {
        snapshot = .init()
        let sections = HomeSection.allCases
        snapshot.appendSections(sections)
        sections.forEach {
            switch $0 {
            case .recommend:
                snapshot.appendItems(self.viewModel.recommendedProducts.map({ $0.id }), toSection: $0)
            case .event:
                snapshot.appendItems(self.viewModel.events.map({ $0.id }), toSection: $0)
            case .news:
                snapshot.appendItems(self.viewModel.news.map({ $0.id }), toSection: $0)
            case .relation:
                snapshot.appendItems(self.viewModel.relationProducts.map({ $0.id }), toSection: $0)
            case .magazine:
                snapshot.appendItems(self.viewModel.magazines.map({ $0.id }), toSection: $0)
            case .last:
                snapshot.appendItems(["Footer"], toSection: $0)
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
