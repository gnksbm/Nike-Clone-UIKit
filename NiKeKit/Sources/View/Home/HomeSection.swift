//
//  HomeSection.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/03.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import Foundation

enum HomeSection: CaseIterable {
    case recommend, event, news, relation, magazine
    
    var header: Header {
        switch self {
        case .recommend:
            return .init(title: "맞춤 추천 제품", subtitle: "추천 제품")
        case .event:
            return .init(title: "", subtitle: "")
        case .news:
            return .init(title: "나이키 소식")
        case .relation:
            return .init(title: "연관 제품", subtitle: "라이프스타일")
        case .magazine:
            return .init(title: "영감을 주는 스토리")
        }
    }
}

extension HomeSection {
    struct Header {
        var title: String
        var subtitle: String?
    }
}
