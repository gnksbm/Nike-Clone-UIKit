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
        config.baseForegroundColor = UIColor(named: NikeKitAsset.accentColor.name)
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
            var headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
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
                headerSupplementary.contentInsets = .init(top: 40,
                                                          leading: 10,
                                                          bottom: 20,
                                                          trailing: 10)
                section.boundarySupplementaryItems = [headerSupplementary]
                section.contentInsets = .init(top: 20,
                                              leading: 15,
                                              bottom: 130,
                                              trailing: 0)
            default:
                group = .horizontal(layoutSize: .init(
                    widthDimension: .fractionalWidth(0.6/4),
                    heightDimension: .estimated(20)
                ), subitems: [item])
                section = .init(group: group)
                section.orthogonalScrollingBehavior = .continuous
            }
            return section
        }
        layout.register(MagazineBackgroundView.self, forDecorationViewOfKind: MagazineBackgroundView.identifier)
        return layout
    }
    // MARK: DataSource
    private func configureDataSource() {
        let categorySelectReg = categorySelectRegistration()
        dataSource = .init(collectionView: collectionView) { collectionView, indexPath, item in
            switch PurchaseSection.allCases[indexPath.section] {
            case .top:
                return collectionView.dequeueConfiguredReusableCell(using: categorySelectReg, for: indexPath, item: item)
            default:
                return collectionView.dequeueReusableCell(withReuseIdentifier: "", for: indexPath)
            }
        }
        let topHeaderReg = topHeaderRegistration()
        dataSource.supplementaryViewProvider = { _, _, indexPath in
            switch PurchaseSection.allCases[indexPath.section] {
            case .top:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: topHeaderReg, for: indexPath)
            default:
                return self.collectionView.dequeueConfiguredReusableSupplementary(using: topHeaderReg, for: indexPath)
            }
        }
        updateSnapshot()
    }
    
    private func categorySelectRegistration() -> UICollectionView.CellRegistration<CategorySelectCell, String> {
        return .init { cell, indexPath, title in
            cell.label.text = title
            cell.label.textColor = indexPath.row == self.viewModel.selectionTag ? .black : .gray
        }
    }
    
    private func topHeaderRegistration() -> UICollectionView.SupplementaryRegistration<ProductCategoryHeader> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.titleLabel.text = "구매하기"
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
                break
            case .image:
                break
            case .outer:
                break
            case .acgNew:
                break
            case .earlyAccess:
                break
            case .weeklyBest:
                break
            case .sport:
                break
            case .searchTrending:
                break
            case .recentlyViewed:
                break
            case .interest:
                break
            case .brand:
                break
            case .Information:
                break
            case .nearby:
                break
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
