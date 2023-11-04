//
//  Magazine.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/04.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import Foundation

import UIKit

struct Magazine: Identifiable {
    let id: String
    var image: UIImage
    var author: String
    var title: String
    
    init(id: String = UUID().uuidString,
         image: UIImage,
         author: String,
         title: String) {
        self.id = id
        self.image = image
        self.author = author
        self.title = title
    }
}

extension Magazine {
    static let sample1: Self = .init(image: NikeKitAsset.storeImage.image, author: "나이키 아카이브 팀", title: "끝없이 이어지는 위대한 유산")
    static let sample2: Self = .init(image: NikeKitAsset.storeImage.image, author: "혁신", title: "포장재를 반으로 줄이는 나이키의 특별한 원박스 배송")
    static let sample3: Self = .init(image: NikeKitAsset.storeImage.image, author: "스타일링 팁", title: "여성을 위한 5가지 골프 필드 스타일")
}
