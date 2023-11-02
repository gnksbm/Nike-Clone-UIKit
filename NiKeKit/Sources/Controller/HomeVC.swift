//
//  HomeVC.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit

class HomeVC: UIViewController {
    enum Section: Int, CaseIterable {
        case recommend, news, relation, inspiration
        
        var sectionTitle: String {
            switch self {
            case .recommend:
                return "맞춤 추천 제품"
            case .news:
                return "나이키 소식"
            case .relation:
                return "연관 제품"
            case .inspiration:
                return "영감을 주는 스토리"
            }
        }
    }
    
    var dataSource: UICollectionViewDiffableDataSource<Section, Product>!
    var snapshot: NSDiffableDataSourceSnapshot<Section, Product>!
    
    lazy var collectionView: UICollectionView = {
        let cv = UICollectionView(frame: .zero, collectionViewLayout: makeLayout())
        cv.register(ProductCVCell.self, forCellWithReuseIdentifier: ProductCVCell.identifier)
        return cv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationController?.topViewController?.title = "님, 즐거운 보내고 계신가요?"
//        title = "님, 즐거운 보내고 계신가요?"
        navigationController?.navigationBar.prefersLargeTitles = true
        setNavigation()
        configureUI()
        configureDataSource()
    }
    
    func setNavigation() {
        let searchItem = UIBarButtonItem(systemItem: .search)
        searchItem.tintColor = .white
        navigationItem.rightBarButtonItem = searchItem
    }
    
    func configureUI() {
        [collectionView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        
        let safeArea = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor),
        ])
    }
}

extension HomeVC {
    func makeLayout() -> UICollectionViewCompositionalLayout {
        return .init { _, _ in
            let item: NSCollectionLayoutItem
            let group: NSCollectionLayoutGroup
            let section: NSCollectionLayoutSection
            let headerSupplementary: NSCollectionLayoutBoundarySupplementaryItem
            item = .init(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .fractionalHeight(1)
                )
            )
            group = .horizontal(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(0.45),
                    heightDimension: .fractionalHeight(1/6)
                ), subitems: [item]
            )
            group.contentInsets = .init(top: 5, leading: 0, bottom: 0, trailing: 5)
            headerSupplementary = NSCollectionLayoutBoundarySupplementaryItem(
                layoutSize: .init(
                    widthDimension: .fractionalWidth(1),
                    heightDimension: .absolute(50)
                ),
                elementKind: UICollectionView.elementKindSectionHeader,
                alignment: .top
            )
            section = .init(group: group)
            section.boundarySupplementaryItems = [headerSupplementary]
            section.orthogonalScrollingBehavior = .continuous
            return section
        }
    }
    
    func configureDataSource() {
        dataSource = .init(collectionView: collectionView, cellProvider: { collectionView, indexPath, _ in
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ProductCVCell.identifier, for: indexPath)
            return cell
        })
        let supplementaryRegistration = UICollectionView.SupplementaryRegistration<HomeCVHeaderView>.init(elementKind: UICollectionView.elementKindSectionHeader) { [weak self] supplementaryView, _, indexPath in
            guard let self else {
                fatalError(#function + ": fail to optional bind")
            }
            guard let sectionKind = Section(rawValue: indexPath.section) else {
                fatalError(#function + ": fail to optional bind")
            }
            supplementaryView.sectiomTitlelabel.text = sectionKind.sectionTitle
        }
        dataSource.supplementaryViewProvider = { [weak self] _, _, indexPath in
            return self?.collectionView.dequeueConfiguredReusableSupplementary(using: supplementaryRegistration, for: indexPath)
        }
        updateSnapshot()
    }
    
    func updateSnapshot() {
        snapshot = .init()
        snapshot.appendSections(Section.allCases)
//        snapshot.appendItems([])
        dataSource.apply(snapshot)
    }
}

import SwiftUI
struct HomeVC_Preview: PreviewProvider {
    static var previews: some View {
        UIKitPreview(selectedIndex: 0)
    }
}
