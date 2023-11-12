//
//  ShopBasketVC.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit

final class ShopBasketVC: UIViewController {
    private var dataSource: UICollectionViewDiffableDataSource<Int, String>!
    private var snapshot: NSDiffableDataSourceSnapshot<Int, String>!
    
    private let viewModel = ShopBasketViewModel()
    
    private lazy var shopBasketCV: UICollectionView = {
        let layout = makeLayout()
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return cv
    }()
    
    private let orderBtn: UIButton = {
        let button = UIButton(configuration: .nikeWideBtn(title: "주문하기", fontSize: 24))
        return button
    }()
    
    let dividerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray4
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.isNavigationBarHidden = true
        configureUI()
        configureDataSource()
        viewModel.setOnCompleteAction(updateSnapshot)
        viewModel.fetchProducts()
    }
    
    private func configureUI() {
        [shopBasketCV, orderBtn, dividerView].forEach {
            view.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        let safeArea = view.safeAreaLayoutGuide
        
        NSLayoutConstraint.activate([
            orderBtn.widthAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.9),
            orderBtn.heightAnchor.constraint(equalTo: safeArea.widthAnchor, multiplier: 0.18),
            orderBtn.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            orderBtn.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor, constant: -25),
            
            shopBasketCV.topAnchor.constraint(equalTo: safeArea.topAnchor),
            shopBasketCV.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            shopBasketCV.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            shopBasketCV.bottomAnchor.constraint(equalTo: orderBtn.topAnchor, constant: -20),
            
            dividerView.heightAnchor.constraint(equalToConstant: 1),
            dividerView.widthAnchor.constraint(equalTo: safeArea.widthAnchor),
            dividerView.centerYAnchor.constraint(equalTo: shopBasketCV.bottomAnchor),
        ])
    }
}

// MARK: CollectionView
extension ShopBasketVC {
    // MARK: Layout
    private func makeLayout() -> UICollectionViewCompositionalLayout {
        return .init { _, _ in
            let item = NSCollectionLayoutItem(layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .fractionalHeight(1)))
            let group = NSCollectionLayoutGroup.vertical(layoutSize: .init(
                widthDimension: .fractionalWidth(1),
                heightDimension: .estimated(.screenWidth * 0.75)
            ), subitems: [item])
            let header = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalWidth(1/4)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            let footer = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .estimated(1)
                ),
                elementKind: UICollectionView.elementKindSectionFooter,
                alignment: .bottom
            )
            let section = NSCollectionLayoutSection(group: group)
            section.boundarySupplementaryItems = [header, footer]
            section.contentInsets = .init(top: 0,
                                         leading: 25,
                                         bottom: 0,
                                         trailing: 25)
            return section
        }
    }
    // MARK: DataSource
    private func configureDataSource() {
        let cellReg = cellRegistration()
        
        dataSource = .init(collectionView: shopBasketCV) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellReg, for: indexPath, item: item)
        }
        let headerReg = headerRegistration()
        let footerReg = footerRegistration()
        
        dataSource.supplementaryViewProvider = { collectionView, kind, indexPath in
            if kind == UICollectionView.elementKindSectionHeader {
                return collectionView.dequeueConfiguredReusableSupplementary(using: headerReg, for: indexPath)
            } else {
                return collectionView.dequeueConfiguredReusableSupplementary(using: footerReg, for: indexPath)
            }
        }
        updateSnapshot()
    }
    
    private func cellRegistration() -> UICollectionView.CellRegistration<BasketCell, String> {
        return .init { cell, _, id in
            guard let item = self.viewModel.basketItem.first(where: { $0.id == id }) else { return }
            if let image = item.product.images.first {
                cell.productImageView.image = image
            }
            let mutableStr = NSMutableAttributedString(string: "수량 \(item.count)")
            mutableStr.addAttribute(.font, value: UIFont.systemFont(ofSize: 18, weight: .medium), range: ("수량 \(item.count)" as NSString).range(of: "\(item.count)"))
            cell.quantityBtn.setAttributedTitle(mutableStr as NSAttributedString, for: .normal)
            cell.priceLabel.text = item.product.price.toPriceStr
            cell.titleLabel.text = item.product.name
            cell.categoryLabel.text = item.product.category.toString
            cell.detailLabel.text = item.product.madeIn.toString
            if let promotion = item.product.promotion {
                cell.promotionImageView.tintColor = .systemGreen
                cell.promotionLabel.textColor = .systemGreen
                cell.promotionLabel.text = promotion.description + " 적용"
            }
        }
    }
    
    private func headerRegistration()
    -> UICollectionView.SupplementaryRegistration<TopHeaderView> {
        return .init(elementKind: UICollectionView.elementKindSectionHeader) { header, _, _ in
            header.titleLabel.text = "장바구니"
        }
    }
    
    private func footerRegistration()
    -> UICollectionView.SupplementaryRegistration<BasketFooterView> {
        return .init(elementKind: UICollectionView.elementKindSectionFooter) { footer, _, _ in
            footer.promotionLabel.text = self.viewModel.promotion == nil ? "프로모션 코드가 있으신가요?" : "프로모션 코드"
            if let promotion = self.viewModel.promotion {
                var titleContainer = AttributeContainer()
                titleContainer.font = .systemFont(ofSize: 14, weight: .medium)
                footer.promotionBtn.configuration?.attributedTitle = AttributedString(promotion.description, attributes: titleContainer)
            }
            footer.priceView.titleLabel.text = "상품 금액"
            footer.priceView.valueLabel.text = self.viewModel.totalPrice.toPriceStr
            footer.priceView.setForegroundColor(.gray)
            if self.viewModel.discountPrice != 0 {
                footer.discountView.titleLabel.text = "프로모션 할인"
                footer.discountView.valueLabel.text = self.viewModel.discountPrice.toPriceStr
            }
            footer.discountView.setForegroundColor(.systemGreen)
            footer.deliveryView.titleLabel.text = "배송 옵션"
            footer.deliveryView.valueLabel.text = self.viewModel.delivery.value.toPriceStr
            footer.deliveryView.setForegroundColor(.gray)
            footer.totalPriceView.titleLabel.text = "총 결제 금액"
            footer.totalPriceView.valueLabel.text = self.viewModel.accountOfPayment.toPriceStr
            footer.totalPriceView.setForegroundColor(NikeKitAsset.accentColor.color)
        }
    }
    // MARK: Snapshot
    private func updateSnapshot() {
        snapshot = .init()
        snapshot.appendSections([0])
        snapshot.appendItems(self.viewModel.basketItem.map({ $0.id }))
        dataSource.apply(snapshot)
    }
}

import SwiftUI
struct ShopBasketVC_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 3)
    }
}
