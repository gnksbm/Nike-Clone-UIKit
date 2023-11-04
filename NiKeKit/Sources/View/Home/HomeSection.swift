//
//  HomeSection.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/03.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import Foundation

enum HomeSection: CaseIterable {
    case recommend, event, news, relation, inspiration
    
    var header: Header {
        switch self {
        case .recommend:
            return .init(title: "맞춤 추천 제품", subTitle: "추천 제품")
        case .event:
            return .init(title: "", subTitle: "")
        case .news:
            return .init(title: "나이키 소식")
        case .relation:
            return .init(title: "연관 제품", subTitle: "라이프스타일")
        case .inspiration:
            return .init(title: "영감을 주는 스토리")
        }
    }
}

extension HomeSection {
    struct Header {
        var title: String
        var subTitle: String?
    }
}
