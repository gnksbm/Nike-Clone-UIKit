//
//  Event.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/03.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

struct Event: Identifiable {
    let id: String
    var image: UIImage
    var title: String
    var content: String
    
    init(id: String = UUID().uuidString,
         image: UIImage,
         title: String,
         content: String) {
        self.id = id
        self.image = image
        self.title = title
        self.content = content
    }
}

extension Event {
    static let sample1: Self = .init(image: NikeKitAsset.nikeBack.image, title: "나이키 앱과 함께하는 특별한 금요일", content: "지금 바로 이벤트에 참여하고 위시리스트 속 제품을 선물로 받아 보세요")
    static let sample2: Self = .init(image: NikeKitAsset.nikeBack.image, title: "나이키 앱 첫 구매 15% 할인", content: "나이키 앱 멤버들에게만 제공되는 (첫 구매 15%) 할인 혜택을 만나 보세요")
}
