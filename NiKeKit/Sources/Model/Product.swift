//
//  Product.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit

struct Product: Hashable {
    var images: [UIImage?]
    let category: Category
    let productName: String
    let code: String
    let colors: [String?]
    let madeIn: Country
}

enum Country: Hashable {
    case indonesia
}

extension Product {
    static let sample1: Self = .init(images: [UIImage(systemName: "shoeprints.fill")], category: .shoes(size: [
        .s225(stock: 1),
        .s235(stock: 1),
        .s245(stock: 1),
        .s255(stock: 1),
    ]), productName: "나이키 코르테즈", code: "DM4044-100", colors: [
        "white",
        "lightPhotoBlue",
        "shale",
        "black",
    ], madeIn: .indonesia)
}
