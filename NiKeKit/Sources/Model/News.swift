//
//  News.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/04.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

struct News: Identifiable {
    let id: String
    var image: UIImage
    var title: String
    var subtitle: String
    var interaction: String
    
    init(id: String = UUID().uuidString,
         image: UIImage,
         title: String,
         subtitle: String,
         interaction: String) {
        self.id = id
        self.image = image
        self.title = title
        self.subtitle = subtitle
        self.interaction = interaction
    }
}

extension News {
    static let sample1: Self = .init(image: NikeKitAsset.nikeBack.image, title: "금요일엔 나이키 앱", subtitle: "두 번째 미션 공개", interaction: "자세히 보기")
    static let sample2: Self = .init(image: NikeKitAsset.nikeBack.image, title: "Run Your Run", subtitle: "달려봐,\n너만의 방식대로.", interaction: "자세히 보기")
}
