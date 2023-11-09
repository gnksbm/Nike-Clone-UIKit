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
    private(set) var outerList: [News] = []
    private(set) var acgNewList: [News] = []
    private(set) var earlyAccessList: [News] = []
    private(set) var weeklyBestList: [News] = []
    private(set) var sportsList: [News] = []
    private(set) var recentlyViewedList: [News] = []
    private(set) var interestList: [News] = []
    private(set) var informationList: [News] = []
    private(set) var nearbyList: [News] = []
    private let urlStr = "https://itunes.apple.com/search?term=billevans"
    
    private var onComplete: () -> Void = { }
    
    var selectionTag: Int = 0
    
    func loadImage(url: URL) async -> UIImage? {
        let result = await networkManager.fetchData(url: url)
        switch result {
        case .success(let data):
            return UIImage(data: data)
        case .failure(let error):
            print(#function, error.localizedDescription)
            return nil
        }
    }
    
    func convertToNews(mocks: [MockResult]) async -> [News] {
        var newsList = [News]()
        await mocks.asyncForEach { [weak self] mock in
            guard let url = URL(string: mock.imageURLStr),
                  let title = mock.title,
                  let image = await self?.loadImage(url: url)
            else { return }
            newsList.append(News(image: image, title: title, subtitle: "", interaction: ""))
        }
        return newsList
    }
    
    func fetchProducts() async {
        guard let url = URL(string: urlStr) else { return }
        let result = await networkManager.fetchObject(type: Mock.self, url: url)
        bestCollectionList = []
        outerList = []
        acgNewList = []
        earlyAccessList = []
        weeklyBestList = []
        sportsList = []
        recentlyViewedList = []
        interestList = []
        informationList = []
        nearbyList = []
        switch result {
        case .success(let success):
            let newsList = await convertToNews(mocks: success.results)
            for (index, news) in newsList.enumerated() {
                if case let sectionIndex = index % 10 {
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
                        informationList.append(news)
                    default:
                        nearbyList.append(news)
                    }
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
