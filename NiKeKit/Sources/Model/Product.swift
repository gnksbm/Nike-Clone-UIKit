//
//  Product.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit

struct Product: Hashable {
    let id: String
    let productName: String
    let category: Category
    let price: Int
    var images: [UIImage?]
    let code: String
    let colors: [String?]
    let madeIn: Country
    
    init(id: String = UUID().uuidString,
         productName: String,
         category: Category,
         price: Int,
         images: [UIImage?],
         code: String,
         colors: [String?],
         madeIn: Country) {
        self.id = id
        self.productName = productName
        self.category = category
        self.price = price
        self.images = images
        self.code = code
        self.colors = colors
        self.madeIn = madeIn
    }
}

enum Country: Hashable {
    case indonesia
    
    var toString: String {
        switch self {
        case .indonesia:
            return "인도네시아"
        }
    }
}

extension Product {
    static let sample1: Self = .init(
        productName: "나이키 코르테즈",
        category: .shoes(size: [
            .s225(stock: 1),
            .s235(stock: 1),
            .s245(stock: 1),
            .s255(stock: 1),
        ]),
        price: 119000,
        images: [NikeKitAsset.progress.image],
        code: "DM4044-100",
        colors: [
            "white",
            "lightPhotoBlue",
            "shale",
            "black",
        ],
        madeIn: .indonesia
    )
    static let sample2: Self = .init(
        productName: "나이키 코르테즈2",
        category: .shoes(size: [
            .s225(stock: 1),
            .s235(stock: 1),
            .s245(stock: 1),
            .s255(stock: 1),
        ]),
        price: 119000,
        images: [NikeKitAsset.progress.image],
        code: "DM4044-100",
        colors: [
            "white",
            "lightPhotoBlue",
            "shale",
            "black",
        ],
        madeIn: .indonesia
    )
    static let sample3: Self = .init(
        productName: "나이키 코르테즈3123123123",
        category: .shoes(size: [
            .s225(stock: 1),
            .s235(stock: 1),
            .s245(stock: 1),
            .s255(stock: 1),
        ]),
        price: 119000,
        images: [NikeKitAsset.progress.image],
        code: "DM4044-100",
        colors: [
            "white",
            "lightPhotoBlue",
            "shale",
            "black",
        ],
        madeIn: .indonesia
    )
    static let sample4: Self = .init(
        productName: "나이키 코르테즈4",
        category: .shoes(size: [
            .s225(stock: 1),
            .s235(stock: 1),
            .s245(stock: 1),
            .s255(stock: 1),
        ]),
        price: 119000,
        images: [NikeKitAsset.progress.image],
        code: "DM4044-100",
        colors: [
            "white",
            "lightPhotoBlue",
            "shale",
            "black",
        ],
        madeIn: .indonesia
    )
    static let sample5: Self = .init(
        productName: "나이키 코르테즈5",
        category: .shoes(size: [
            .s225(stock: 1),
            .s235(stock: 1),
            .s245(stock: 1),
            .s255(stock: 1),
        ]),
        price: 119000,
        images: [NikeKitAsset.progress.image],
        code: "DM4044-100",
        colors: [
            "white",
            "lightPhotoBlue",
            "shale",
            "black",
        ],
        madeIn: .indonesia
    )
    static let sample6: Self = .init(
        productName: "나이키 코르테즈6",
        category: .shoes(size: [
            .s225(stock: 1),
            .s235(stock: 1),
            .s245(stock: 1),
            .s255(stock: 1),
        ]),
        price: 119000,
        images: [NikeKitAsset.progress.image],
        code: "DM4044-100",
        colors: [
            "white",
            "lightPhotoBlue",
            "shale",
            "black",
        ],
        madeIn: .indonesia
    )
}
