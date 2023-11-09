//
//  PurchaseSection.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/06.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import Foundation

enum PurchaseSection: CaseIterable {
    case top, bestCollection, imageCategory, outer, acgNew, earlyAccess, weeklyBest, sport, searchTrending, recentlyViewed, interest, brand, information, nearby
    
    var title: String {
        switch self {
        case .top:
            return "구매하기"
        case .bestCollection:
            return "나이키 앱 베스트 컬렉션"
        case .imageCategory:
            return ""
        case .outer:
            return "나이키 아우터"
        case .acgNew:
            return "ACG 신제품"
        case .earlyAccess:
            return "App Early Access 🔒"
        case .weeklyBest:
            return "11월 첫째 주 베스트 아이템 🏅"
        case .sport:
            return "스포츠별 구매하기"
        case .searchTrending:
            return "인기 검색어"
        case .recentlyViewed:
            return "최근 본 제품"
        case .interest:
            return "관심 제품 구매하기"
        case .brand:
            return "브랜드별 구매하기"
        case .information:
            return "Information Center"
        case .nearby:
            return "근처 매장"
        }
    }
}
