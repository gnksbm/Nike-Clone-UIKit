//
//  PurchaseSection.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/06.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import Foundation

enum PurchaseSection: CaseIterable {
    case top, bestCollection, wideImage, outer, acgNew, earlyAccess, weeklyBest, sport, searchTrending, recentlyViewed, interest, brand, information, nearby
    
    var header: Header {
        switch self {
        case .top:
            return Header(title: "구매하기")
        case .bestCollection:
            return Header(title: "나이키 앱 베스트 컬렉션")
        case .wideImage:
            return Header(title: "")
        case .outer:
            return Header(title: "나이키 아우터")
        case .acgNew:
            return Header(title: "ACG 신제품")
        case .earlyAccess:
            return Header(title: "App Early Access 🔒", subtitle: "나이키 앱에서 먼저 만나보세요.")
        case .weeklyBest:
            return Header(title: "11월 첫째 주 베스트 아이템 🏅")
        case .sport:
            return Header(title: "스포츠별 구매하기")
        case .searchTrending:
            return Header(title: "인기 검색어")
        case .recentlyViewed:
            return Header(title: "최근 본 제품")
        case .interest:
            return Header(title: "관심 제품 구매하기")
        case .brand:
            return Header(title: "브랜드별 구매하기")
        case .information:
            return Header(title: "Information Center")
        case .nearby:
            return Header(title: "근처 매장")
        }
    }
}

extension PurchaseSection {
    struct Header {
        var title: String
        var subtitle: String?
    }
}
