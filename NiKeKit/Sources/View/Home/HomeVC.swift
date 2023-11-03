//
//  HomeVC.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit
protocol HomeCell: Hashable { }

class HomeVC: UIViewController {
    var dataSource: UICollectionViewDiffableDataSource<HomeSection, Product>!
    var snapshot: NSDiffableDataSourceSnapshot<HomeSection, Product>!
    
    let viewModel = HomeViewModel()
    
//    lazy var titleMsgLabel: UILabel = {
//        let label = UILabel()
//        label.text = viewModel.titleMessage
//        label.font = .systemFont(ofSize: UIFont.labelFontSize, weight: .medium)
//        label.textAlignment = .center
//        return label
//    }()
    
    lazy var searchBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        config.baseForegroundColor = UIColor(named: NikeKitAsset.accentColor.name)
        config.image = UIImage(systemName: "magnifyingglass")
        let btn = UIButton(configuration: config)
        return btn
    }()
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        cv.register(ProductCVCell.self, forCellWithReuseIdentifier: ProductCVCell.identifier)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        configureDataSource()
        viewModel.setOnCompleteAction(updateSnapshot)
        viewModel.fetchProducts()
    }
    
    func setNavigation() {
        let searchItem = UIBarButtonItem(systemItem: .search)
        searchItem.tintColor = UIColor(named: NikeKitAsset.accentColor.name)
        navigationItem.rightBarButtonItem = searchItem
    }
    
    func configureUI() {
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
    func makeLayout() -> UICollectionViewCompositionalLayout {
        return .init { section, _ in
            let sectionKind = HomeSection.allCases[section]
            let item = NSCollectionLayoutItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            let group = NSCollectionLayoutGroup.horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(0.45),
                    heightDimension: .estimated(.screenHeight / 2.5)
                ), subitems: [item]
            )
            group.contentInsets = .sameEdge(value: 5)
            let headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(.screenHeight / 10)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            headerSupplementary.contentInsets = .init(top: 20, leading: 20, bottom: 20, trailing: 10)
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [headerSupplementary]
            section.contentInsets = .init(top: 20, leading: 10, bottom: 0, trailing: 0)
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
    }
    
    func configureDataSource() {
        let cellRegistration = makeCellRegistration()
        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, product in
            let cell = collectionView.dequeueConfiguredReusableCell(using: cellRegistration, for: indexPath, item: product)
            return cell
        })
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<HomeCVHeaderView>.init(elementKind: UICollectionView.elementKindSectionHeader) { supplementaryView, _, indexPath in
            let sectionKind = HomeSection.allCases[indexPath.section]
            supplementaryView.section = sectionKind
            supplementaryView.configureUI()
            supplementaryView.msgLabel.text = self.viewModel.titleMessage
            supplementaryView.titlelabel.text = sectionKind.header.title
            if let subtitle = sectionKind.header.subTitle {
                supplementaryView.subTitlelabel.text = subtitle
            }
            supplementaryView.showBtn.setTitle("모두 보기", for: .normal)
        }
        dataSource.supplementaryViewProvider = { [weak self] _, _, indexPath in
            return self?.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
        }
        updateSnapshot()
    }
    
    func makeCellRegistration() -> UICollectionView.CellRegistration<ProductCVCell, Product> {
        return UICollectionView.CellRegistration<ProductCVCell, Product> { cell, indexPath, product in
            switch HomeSection.allCases[indexPath.section] {
            case .recommend:
                if let image = product.images.first {
                    cell.imageView.image = image
                }
                cell.titleLabel.text = product.productName
                cell.categoryLabel.text = product.category.toString
                cell.priceLabel.text = product.price.toPriceStr
            case .news:
                break
            case .relation:
                break
            case .inspiration:
                break
            }
        }
    }
    
    func updateSnapshot() {
        snapshot = .init()
        snapshot.appendSections(HomeSection.allCases)
        snapshot.appendItems(self.viewModel.products, toSection: .recommend)
        dataSource.apply(snapshot)
    }
}

import SwiftUI
struct HomeVC_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 0)
    }
}
