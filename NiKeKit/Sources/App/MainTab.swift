//
//  MainTab.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit

enum MainTab: Int, CaseIterable {
    case home, purchase, wishList, basket, profile
    
    var info: ViewInfo {
        switch self {
        case .home:
            return .init(title: "홈", imgName: "house", vc: HomeVC())
        case .purchase:
            return .init(title: "구매하기", imgName: "magnifyingglass", vc: PurchaseVC())
        case .wishList:
            return .init(title: "위시리스트", imgName: "heart", vc: WishListVC())
        case .basket:
            return .init(title: "장바구니", imgName: "bag", vc: ShopBasketVC())
        case .profile:
            return .init(title: "프로필", imgName: "person", vc: ProfileVC())
        }
    }
    
    static func makeAllCasesToViewControllers() -> [UINavigationController] {
        var navigationControllers: [UINavigationController] = []
        
        Self.allCases.forEach {
            let navigationController = UINavigationController(rootViewController: $0.info.vc)
            navigationController.tabBarItem = UITabBarItem(title: $0.info.title, image: UIImage(systemName: $0.info.imgName), tag: $0.rawValue)
            navigationController.tabBarItem.selectedImage = UIImage(systemName: $0.info.imgName)
            navigationControllers.append(navigationController)
            if $0 == .home || $0 == .purchase {
                let searchItem = UIBarButtonItem(systemItem: .search)
                searchItem.tintColor = NikeKitAsset.accentColor.color
                navigationController.navigationItem.rightBarButtonItem = searchItem
            }
        }
        
        return navigationControllers
    }
    
    struct ViewInfo {
        let title: String
        let imgName: String
        let vc: UIViewController
    }
}
