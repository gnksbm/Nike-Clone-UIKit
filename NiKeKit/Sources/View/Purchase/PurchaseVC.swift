//
//  PurchaseVC.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit

class PurchaseVC: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<PurchaseSection, String>!
    private var snapshot: NSDiffableDataSourceSnapshot<PurchaseSection, String>!
    
    private let viewModel = PurchaseViewModel()
    
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
        cv.dataSource = dataSource
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
        viewModel.setOnCompleteAction(updateSnapshot)
        Task {
            await viewModel.fetchProducts()
        }
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        navigationController?.isNavigationBarHidden = true
        
        [searchBtn, collectionView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            searchBtn.topAnchor.constraint(equalTo: safeArea.topAnchor),
            searchBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -5),
            
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: searchBtn.bottomAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
}
// MARK: CollectionView
extension PurchaseVC {
    // MARK: Layout
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        let layout = UICollectionViewCompositionalLayout { index, _ in
            let sectionKind = PurchaseSection.allCases[index]
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            var group: NSCollectionLayoutGroup
            var section: NSCollectionLayoutSection
            let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(100)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            switch sectionKind {
            case .top:
                group = .horizontal(layoutSize: .init(
                    widthDimension: .fractionalWidth(0.6/4),
                    heightDimension: .estimated(50)
                ), subitems: [item])
                section = .init(group: group)
                section.orthogonalScrollingBehavior = .continuous
                let footerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .estimated(1)
                    ),
                    elementKind: UICollectionView.elementKindSectionFooter,
                    alignment: .bottom
                )
                headerSupplementary.contentInsets = .init(top: 40,
                                                          leading: 10,
                                                          bottom: 20,
                                                          trailing: 10)
                footerSupplementary.contentInsets = .init(top: 0,
                                                          leading: -15,
                                                          bottom: 0,
                                                          trailing: 0)
                section.boundarySupplementaryItems = [headerSupplementary, footerSupplementary]
                section.contentInsets = .init(top: 20,
                                              leading: 15,
                                              bottom: 0,
                                              trailing: 0)
            case .bestCollection:
                group = .horizontal(layoutSize: .init(
                    widthDimension: .fractionalWidth(1/2.5),
                    heightDimension: .fractionalWidth(1/2.5)
                ), subitems: [item])
                group.contentInsets = .sameInset(3)
                headerSupplementary.contentInsets = .init(top: 0,
                                                          leading: 5,
                                                          bottom: 0,
                                                          trailing: 0)
                section = .init(group: group)
                section.boundarySupplementaryItems = [headerSupplementary]
                section.contentInsets = .init(top: 0,
                                              leading: 20,
                                              bottom: 80,
                                              trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
            case .wideImage:
                group = .horizontal(layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1/3.5)
                ), subitems: [item])
                group.contentInsets = .init(top: 0,
                                            leading: 0,
                                            bottom: 3,
                                            trailing: 0)
                section = .init(group: group)
                section.contentInsets = .init(top: 0,
                                              leading: 0,
                                              bottom: 20,
                                              trailing: 0)
            case .outer, .acgNew, .earlyAccess, .weeklyBest, .sport, .recentlyViewed, .information:
                group = .horizontal(layoutSize: .init(
                    widthDimension: .fractionalWidth(1/2.5),
                    heightDimension: .fractionalWidth(1/2.5)
                ), subitems: [item])
                group.contentInsets = .sameInset(3)
                headerSupplementary.contentInsets = .init(top: 0,
                                                          leading: 5,
                                                          bottom: 0,
                                                          trailing: 10)
                section = .init(group: group)
                section.boundarySupplementaryItems = [headerSupplementary]
                section.contentInsets = .init(top: 0,
                                              leading: 20,
                                              bottom: 60,
                                              trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
            case .interest, .nearby:
                group = .horizontal(layoutSize: .init(
                    widthDimension: .fractionalWidth(0.7),
                    heightDimension: .fractionalWidth(0.7)
                ), subitems: [item])
                group.contentInsets = .sameInset(3)
                headerSupplementary.contentInsets = .init(top: 0,
                                                          leading: 5,
                                                          bottom: 0,
                                                          trailing: 10)
                section = .init(group: group)
                section.boundarySupplementaryItems = [headerSupplementary]
                section.contentInsets = .init(top: 0,
                                              leading: 20,
                                              bottom: 60,
                                              trailing: 0)
                section.orthogonalScrollingBehavior = .continuous
            case .searchTrending:
                group = .horizontal(layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(30)
                ), subitems: [item])
                group.contentInsets = .init(top: 0,
                                            leading: 0,
                                            bottom: 3,
                                            trailing: 0)
                headerSupplementary.contentInsets = .init(top: 0,
                                                          leading: 5,
                                                          bottom: 0,
                                                          trailing: 10)
                section = .init(group: group)
                section.boundarySupplementaryItems = [headerSupplementary]
                section.contentInsets = .init(top: 0,
                                              leading: 20,
                                              bottom: 60,
                                              trailing: 0)
            case .brand:
                let vItem = NSCollectionLayoutItem(
                    layoutSize: .init(
                        widthDimension: .fractionalWidth(1),
                        heightDimension: .fractionalHeight(1/2)
                    )
                )
                let vGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(
                    widthDimension: .fractionalWidth(1/3),
                    heightDimension: .fractionalHeight(1)
                ), subitems: [vItem])
                group = .horizontal(layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(2/3)
                ), subitems: [vGroup])
                headerSupplementary.contentInsets = .init(top: 0,
                                                          leading: 5,
                                                          bottom: 0,
                                                          trailing: 10)
                section = .init(group: group)
                section.contentInsetsReference = .layoutMargins
                section.boundarySupplementaryItems = [headerSupplementary]
                section.contentInsets = .init(top: 0,
                                              leading: 20,
                                              bottom: 0,
                                              trailing: 20)
            }
            return section
        }
        layout.register(AccentBackgroundView.self, forDecorationViewOfKind: AccentBackgroundView.identifier)
        return layout
    }
    // MARK: DataSource
    private func configureDataSource() {
        let categorySelectReg = categorySelectRegistration()
        let bestCollectionReg = bestCollectionRegistration()
        let wideImageReg = wideImageRegistration()
        let outerListReg = outerListRegistration()
        let acgNewListReg = acgNewListRegistration()
        let earlyAccessListReg = earlyAccessListRegistration()
        let weeklyBestListReg = weeklyBestListRegistration()
        let sportsListReg = sportsListRegistration()
        let searchTrendingReg = searchTrendingRegistration()
        let recentlyViewedListReg = recentlyViewedListRegistration()
        let interestListReg = interestListRegistration()
        let brandListReg = brandListRegistration()
        let informationListReg = informationListRegistration()
        let nearbyListReg = nearbyListRegistration()
        
        dataSource = .init(collectionView: collectionView) { collectionView, indexPath, item in
            switch PurchaseSection.allCases[indexPath.section] {
            case .top:
                return collectionView.dequeueConfiguredReusableCell(using: categorySelectReg, for: indexPath, item: item)
            case .bestCollection:
                return collectionView.dequeueConfiguredReusableCell(using: bestCollectionReg, for: indexPath, item: item)
            case .wideImage:
                return collectionView.dequeueConfiguredReusableCell(using: wideImageReg, for: indexPath, item: item)
            case .outer:
                return self.collectionView.dequeueConfiguredReusableCell(using: outerListReg, for: indexPath, item: item)
            case .acgNew:
                return self.collectionView.dequeueConfiguredReusableCell(using: acgNewListReg, for: indexPath, item: item)
            case .earlyAccess:
                return self.collectionView.dequeueConfiguredReusableCell(using: earlyAccessListReg, for: indexPath, item: item)
            case .weeklyBest:
                return self.collectionView.dequeueConfiguredReusableCell(using: weeklyBestListReg, for: indexPath, item: item)
            case .sport:
                return self.collectionView.dequeueConfiguredReusableCell(using: sportsListReg, for: indexPath, item: item)
            case .searchTrending:
                return self.collectionView.dequeueConfiguredReusableCell(using: searchTrendingReg, for: indexPath, item: item)
            case .recentlyViewed:
                return self.collectionView.dequeueConfiguredReusableCell(using: recentlyViewedListReg, for: indexPath, item: item)
            case .interest:
                return self.collectionView.dequeueConfiguredReusableCell(using: interestListReg, for: indexPath, item: item)
            case .brand:
                return self.collectionView.dequeueConfiguredReusableCell(using: brandListReg, for: indexPath, item: item)
            case .information:
                return self.collectionView.dequeueConfiguredReusableCell(using: informationListReg, for: indexPath, item: item)
            case .nearby:
                return self.collectionView.dequeueConfiguredReusableCell(using: nearbyListReg, for: indexPath, item: item)
            }
        }
        let topHeaderReg = topHeaderRegistration()
        let topFooterReg = topFooterRegistration()
        let onlyTitleHeaderReg = onlyTitleHeaderRegistration()
        let recentlyViewedHeaderReg = recentlyViewedHeaderRegistration()
        let interestHeaderReg = interestHeaderRegistration()
        let nearbyHeaderReg = nearbyHeaderRegistration()
        let earlyAccessHeaderReg = earlyAccessHeaderRegistration()
        
        dataSource.supplementaryViewProvider = { _, kind, indexPath in
            switch PurchaseSection.allCases[indexPath.section] {
            case .top:
                if kind == UICollectionView.elementKindSectionHeader {
                    return self.collectionView.dequeueConfiguredReusableSupplementary(using: topHeaderReg, for: indexPath)
                } else {
                    return self.collectionView.dequeueConfiguredReusableSupplementary(using: topFooterReg, for: indexPath)
                }
            case .bestCollection:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: onlyTitleHeaderReg, for: indexPath)
            case .recentlyViewed:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: recentlyViewedHeaderReg, for: indexPath)
            case .interest:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: interestHeaderReg, for: indexPath)
            case .nearby:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: nearbyHeaderReg, for: indexPath)
            case .earlyAccess:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: earlyAccessHeaderReg, for: indexPath)
            default:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: onlyTitleHeaderReg, for: indexPath)
            }
        }
        updateSnapshot()
    }
    
    private func categorySelectRegistration() -> UICollectionView.CellRegistration<CategorySelectCell, String> {
        return .init { cell, indexPath, title in
            cell.label.text = title
            cell.label.textColor = indexPath.row == self.viewModel.selectionTag ? NikeKitAsset.accentColor.color : .gray
            cell.underLineView.isHidden = indexPath.row != self.viewModel.selectionTag
        }
    }
    
    private func bestCollectionRegistration() -> UICollectionView.CellRegistration<BestCollectionCell, String> {
        return .init { cell, _, id in
            let news = self.viewModel.bestCollectionList.first(where: { $0.id == id })
            cell.imageView.image = news?.image
            cell.titleLabel.text = news?.title
            cell.imageView.layer.cornerRadius = 15
            cell.imageView.clipsToBounds = true
            cell.imageView.layer.cornerCurve = .continuous
        }
    }
    
    private func wideImageRegistration() -> UICollectionView.CellRegistration<WideImageCell, String> {
        return .init { cell, _, id in
            let news = self.viewModel.wideImageList.first(where: { $0.id == id })
            cell.imageView.image = news?.image
            cell.titleLabel.text = news?.title
        }
    }
    
    private func outerListRegistration() -> UICollectionView.CellRegistration<BestCollectionCell, String> {
        return .init { cell, _, id in
            let news = self.viewModel.outerList.first(where: { $0.id == id })
            cell.imageView.image = news?.image
            cell.titleLabel.text = news?.title
        }
    }
    
    private func acgNewListRegistration() -> UICollectionView.CellRegistration<BestCollectionCell, String> {
        return .init { cell, _, id in
            let news = self.viewModel.acgNewList.first(where: { $0.id == id })
            cell.imageView.image = news?.image
            cell.titleLabel.text = news?.title
        }
    }
    
    private func earlyAccessListRegistration() -> UICollectionView.CellRegistration<BestCollectionCell, String> {
        return .init { cell, _, id in
            let news = self.viewModel.earlyAccessList.first(where: { $0.id == id })
            cell.imageView.image = news?.image
            cell.titleLabel.text = news?.title
        }
    }
    
    private func weeklyBestListRegistration() -> UICollectionView.CellRegistration<BestCollectionCell, String> {
        return .init { cell, _, id in
            let news = self.viewModel.weeklyBestList.first(where: { $0.id == id })
            cell.imageView.image = news?.image
            cell.titleLabel.text = news?.title
        }
    }
    
    private func sportsListRegistration() -> UICollectionView.CellRegistration<BestCollectionCell, String> {
        return .init { cell, _, id in
            let news = self.viewModel.sportsList.first(where: { $0.id == id })
            cell.imageView.image = news?.image
            cell.titleLabel.text = news?.title
        }
    }
    
    private func searchTrendingRegistration() -> UICollectionView.CellRegistration<SearchTrendingCell, String> {
        return .init { cell, indexPath, _ in
            cell.titleLabel.text = self.viewModel.searchTrendingList[indexPath.row]
        }
    }
    
    private func recentlyViewedListRegistration() -> UICollectionView.CellRegistration<BestCollectionCell, String> {
        return .init { cell, _, id in
            let news = self.viewModel.recentlyViewedList.first(where: { $0.id == id })
            cell.imageView.image = news?.image
            cell.titleLabel.text = news?.title
        }
    }
    
    private func interestListRegistration() -> UICollectionView.CellRegistration<BestCollectionCell, String> {
        return .init { cell, _, id in
            let news = self.viewModel.interestList.first(where: { $0.id == id })
            cell.imageView.image = news?.image
            cell.titleLabel.text = news?.title
        }
    }
    
    private func brandListRegistration() -> UICollectionView.CellRegistration<BrandCell, String> {
        return .init { cell, _, id in
            let brand = self.viewModel.brandList.first(where: { $0.id == id })
            cell.imageView.image = brand?.image
        }
    }
    
    private func informationListRegistration() -> UICollectionView.CellRegistration<BestCollectionCell, String> {
        return .init { cell, _, id in
            let news = self.viewModel.informationList.first(where: { $0.id == id })
            cell.imageView.image = news?.image
            cell.titleLabel.text = news?.title
        }
    }
    
    private func nearbyListRegistration() -> UICollectionView.CellRegistration<BestCollectionCell, String> {
        return .init { cell, _, id in
            let news = self.viewModel.nearbyList.first(where: { $0.id == id })
            cell.imageView.image = news?.image
            cell.titleLabel.text = news?.title
        }
    }
    
    private func topHeaderRegistration() -> UICollectionView.SupplementaryRegistration<TopHeaderView> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            let section = PurchaseSection.allCases[indexPath.section]
            header.titleLabel.text = section.header.title
        }
    }
    
    private func onlyTitleHeaderRegistration() -> UICollectionView.SupplementaryRegistration<OnlyTitleHeader> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            let section = PurchaseSection.allCases[indexPath.section]
            header.titleLabel.text = section.header.title
        }
    }
    
    private func recentlyViewedHeaderRegistration() -> UICollectionView.SupplementaryRegistration<TitleAndShowBtnHeader> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            let section = PurchaseSection.allCases[indexPath.section]
            header.titleLabel.text = section.header.title
            header.showBtn.setTitle("삭제", for: .normal)
        }
    }
    
    private func interestHeaderRegistration() -> UICollectionView.SupplementaryRegistration<TitleAndShowBtnHeader> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            let section = PurchaseSection.allCases[indexPath.section]
            header.titleLabel.text = section.header.title
            header.showBtn.setTitle("관심사 수정", for: .normal)
        }
    }
    
    private func nearbyHeaderRegistration() -> UICollectionView.SupplementaryRegistration<TitleAndShowBtnHeader> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            let section = PurchaseSection.allCases[indexPath.section]
            header.titleLabel.text = section.header.title
            header.showBtn.setTitle("매장 찾기", for: .normal)
        }
    }
    
    private func earlyAccessHeaderRegistration() -> UICollectionView.SupplementaryRegistration<StackAndShowBtnHeader> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, indexPath in
            let section = PurchaseSection.allCases[indexPath.section]
            header.titleLabel.text = section.header.title
            header.subTitleLabel.text = section.header.subtitle
            header.showBtn.setTitle("매장 찾기", for: .normal)
        }
    }
    
    private func topFooterRegistration() -> UICollectionView.SupplementaryRegistration<UICollectionReusableView> {
        return .init(elementKind: UICollectionView.elementKindSectionFooter) { footer, _, _ in
            footer.backgroundColor = .systemGray3
        }
    }
    // MARK: Snapshot
    private func updateSnapshot() {
        snapshot = .init()
        let sections = PurchaseSection.allCases
        snapshot.appendSections(sections)
        sections.forEach {
            switch $0 {
            case .top:
                snapshot.appendItems(ProductCategory.allCases.map({ $0.toString }), toSection: $0)
            case .bestCollection:
                snapshot.appendItems(self.viewModel.bestCollectionList.map({ $0.id }), toSection: $0)
            case .wideImage:
                snapshot.appendItems(self.viewModel.wideImageList.map({ $0.id }), toSection: $0)
            case .outer:
                snapshot.appendItems(self.viewModel.outerList.map({ $0.id }), toSection: $0)
            case .acgNew:
                snapshot.appendItems(self.viewModel.acgNewList.map({ $0.id }), toSection: $0)
            case .earlyAccess:
                snapshot.appendItems(self.viewModel.earlyAccessList.map({ $0.id }), toSection: $0)
            case .weeklyBest:
                snapshot.appendItems(self.viewModel.weeklyBestList.map({ $0.id }), toSection: $0)
            case .sport:
                snapshot.appendItems(self.viewModel.sportsList.map({ $0.id }), toSection: $0)
            case .searchTrending:
                snapshot.appendItems(self.viewModel.searchTrendingList, toSection: $0)
            case .recentlyViewed:
                snapshot.appendItems(self.viewModel.recentlyViewedList.map({ $0.id }), toSection: $0)
            case .interest:
                snapshot.appendItems(self.viewModel.interestList.map({ $0.id }), toSection: $0)
            case .brand:
                snapshot.appendItems(self.viewModel.brandList.map({ $0.id }), toSection: $0)
            case .information:
                snapshot.appendItems(self.viewModel.informationList.map({ $0.id }), toSection: $0)
            case .nearby:
                snapshot.appendItems(self.viewModel.nearbyList.map({ $0.id }), toSection: $0)
            }
        }
        dataSource.apply(snapshot)
    }
}

import SwiftUI
struct PurchaseVC_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 1)
    }
}
