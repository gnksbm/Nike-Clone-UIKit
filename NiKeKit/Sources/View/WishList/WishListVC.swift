//
//  WishListVC.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit

final class WishListVC: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    private var snapshot: NSDiffableDataSourceSnapshot<Int, String>!
    
    private let viewModel = WishListViewModel()
    
    private lazy var editBtn: UIButton = {
        var config = UIButton.Configuration.plain()
        var titleContainer = AttributeContainer()
        titleContainer.font = .systemFont(ofSize: 18, weight: .medium)
        config.baseForegroundColor = .gray
        config.attributedTitle = AttributedString("편집", attributes: titleContainer)
        let button = UIButton(configuration: config)
        return button
    }()
    
    private let emptyView = EmptyListView(image: UIImage(systemName: "heart"), title: "위시리스트", message: "위시리스트에 추가한 상품이 없습니다.")
    private lazy var wishListCV: UICollectionView = {
        let layout = makeLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setSubView()
        configureDataSource()
        viewModel.setOnCompleteAction(setBinding)
//        viewModel.fetchProducts()
    }
    
    private func setBinding() {
        setSubView()
        updateSnapshot()
    }
    
    private func setSubView() {
        if viewModel.products.isEmpty {
            configureEmptyView()
        } else {
            configureCollectionView()
        }
    }
    
    private func configureEmptyView() {
        navigationController?.isNavigationBarHidden = true
        wishListCV.removeFromSuperview()
        editBtn.removeFromSuperview()
        view.addSubview(emptyView)
        [emptyView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            emptyView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            emptyView.heightAnchor.constraint(equalTo: safeArea.heightAnchor),
            emptyView.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            emptyView.centerYAnchor.constraint(equalTo: safeArea.centerYAnchor),
        ])
    }
    
    private func configureCollectionView() {
        emptyView.removeFromSuperview()
        view.addSubview(wishListCV)
        [editBtn, wishListCV].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            editBtn.topAnchor.constraint(equalTo: safeArea.topAnchor),
            editBtn.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -5),
            
            wishListCV.topAnchor.constraint(equalTo: editBtn.bottomAnchor),
            wishListCV.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            wishListCV.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            wishListCV.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
}
// MARK: CollectionView
extension WishListVC {
    // MARK: Layout
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        return .init { _, _ in
            let item = NSCollectionLayoutItem(layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)))
            let vGroup = NSCollectionLayoutGroup.vertical(layoutSize: .init(
                widthDimension: .fractionalWidth(1/2),
                heightDimension: .fractionalHeight(1)
            ), subitems: [item])
            vGroup.contentInsets = .init(top: 0,
                                       leading: 0,
                                       bottom: 0,
                                       trailing: 5)
            let hGroup = NSCollectionLayoutGroup.horizontal(layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(0.45)
            ), subitems: [vGroup])
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1/4)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            header.contentInsets = .init(top: 0,
                                         leading: 25,
                                         bottom: 0,
                                         trailing: 0)
            let section = NSCollectionLayoutSection(group: hGroup)
            section.boundarySupplementaryItems = [header]
            return section
        }
    }
    // MARK: DataSource
    private func configureDataSource() {
        let cellReg = cellRegistration()
        
        dataSource = .init(collectionView: wishListCV) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellReg, for: indexPath, item: item)
        }
        let headerReg = headerRegistration()
        
        dataSource.supplementaryViewProvider = { collectionView, _, indexPath in
            return collectionView.dequeueConfiguredReusableSupplementary(using: headerReg, for: indexPath)
        }
        updateSnapshot()
    }
    
    private func cellRegistration() -> UICollectionView.CellRegistration<WishListCell, String> {
        return .init { cell, _, id in
            let product = self.viewModel.products.first(where: { $0.id == id })
            if let image = product?.images.first {
                cell.imageView.image = image
            }
            cell.titleLabel.text = product?.name
            cell.priceLabel.text = product?.price.toPriceStr
        }
    }
    
    private func headerRegistration()
    -> UICollectionView.SupplementaryRegistration<TopHeaderView> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.titleLabel.text = "위시리스트"
        }
    }
    // MARK: Snapshot
    private func updateSnapshot() {
        snapshot = .init()
        snapshot.appendSections([0])
        snapshot.appendItems(self.viewModel.products.map({ $0.id }))
        dataSource.apply(snapshot)
    }
}

import SwiftUI
struct WishListVC_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 2)
    }
}
