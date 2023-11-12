//
//  PurchaseViewModel.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/08.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import UIKit

final class PurchaseViewModel {
    private let networkManager = NetworkManager.shared
    
    private(set) var bestCollectionList: [News] = []
    private(set) var wideImageList: [News] = []
    private(set) var outerList: [News] = []
    private(set) var acgNewList: [News] = []
    private(set) var earlyAccessList: [News] = []
    private(set) var weeklyBestList: [News] = []
    private(set) var sportsList: [News] = []
    private(set) var recentlyViewedList: [News] = []
    private(set) var searchTrendingList: [String] = []
    private(set) var interestList: [News] = []
    private(set) var brandList: [Brand] = []
    private(set) var informationList: [News] = []
    private(set) var nearbyList: [News] = []
    
    var selectionTag: Int = 0
    private let urlStr = "https://itunes.apple.com/search?term=billevans"
    private var onComplete: () -> Void = { }
    
    func fetchProducts() async {
        guard let url = URL(string: urlStr) else { return }
        let result = await networkManager.fetchObject(type: Mock.self, url: url)
        bestCollectionList = []
        wideImageList = []
        outerList = []
        acgNewList = []
        earlyAccessList = []
        weeklyBestList = []
        sportsList = []
        recentlyViewedList = []
        searchTrendingList = dummySearchTerm
        interestList = []
        brandList = dummyBrand
        informationList = []
        nearbyList = []
        switch result {
        case .success(let success):
            let newsList = await success.results.convertToNews()
            for (index, news) in newsList.enumerated() {
                let sectionIndex = index % 11
                switch sectionIndex {
                case 0:
                    bestCollectionList.append(news)
                case 1:
                    outerList.append(news)
                case 2:
                    acgNewList.append(news)
                case 3:
                    earlyAccessList.append(news)
                case 4:
                    weeklyBestList.append(news)
                case 5:
                    sportsList.append(news)
                case 6:
                    recentlyViewedList.append(news)
                case 7:
                    interestList.append(news)
                case 8:
                    wideImageList.append(news)
                case 9:
                    informationList.append(news)
                default:
                    nearbyList.append(news)
                }
            }
        case .failure(let error):
            print(#function, error.localizedDescription)
        }
        onComplete()
    }
    
    func setOnCompleteAction(_ handler: @escaping () -> Void) {
        onComplete = handler
    }
}

extension PurchaseViewModel {
    var dummySearchTerm: [String] {
        ["금요일엔 나이키앱", "아우터", "ACG", "덩크", "에어 포스 1", "마라톤 준비", "러닝화", "바람막이", "골프"]
    }
    var dummyBrand: [Brand] {
        [
            Brand(image: NikeKitAsset.nikeLogoWithText.image, title: "nike"),
            Brand(image: NikeKitAsset.nikeLogoSb.image, title: "nikeSB"),
            Brand(image: NikeKitAsset.nikeLogoJordan.image, title: "jordan"),
            Brand(image: NikeKitAsset.nikeLogoLab.image, title: "nikeLab"),
            Brand(image: NikeKitAsset.nikeLogoAcg.image, title: "nikeACG"),
        ]
    }
    
    struct Brand {
        let id: String
        var image: UIImage
        var title: String
        
        init(id: String = UUID().uuidString,
             image: UIImage,
             title: String) {
            self.id = id
            self.image = image
            self.title = title
        }
    }
}
