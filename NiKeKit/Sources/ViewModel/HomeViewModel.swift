//
//  HomeViewModel.swift
//  NikeKit
//
//  Created by gnksbm on 2023/11/02.
//  Copyright © 2023 https://github.com/gnksbm/NikeKit. All rights reserved.
//

import Foundation

final class HomeViewModel {
    private(set) var products: [Product] = []
    private(set) var events: [Event] = []
    private(set) var news: [News] = []
    private(set) var magazines: [Magazine] = []
    
    var recommendedProducts: [Product] {
        products.suffix(3)
    }
    
    var relationProducts: [Product] {
        Array(products.prefix(3))
    }
    
    var titleMessage: String {
        let now: Date = Date()
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "ko_kr")
        dateFormatter.timeZone = TimeZone(abbreviation: "KST")
        dateFormatter.dateFormat = "HH:mm"
        let result = dateFormatter.string(from: now)
        var message: String
        if result < "06:00" {
            message = "님, 꿀잠자고 계시는지~"
        } else if result < "12:00" {
            message = "님, 좋은 아침이에요!"
        } else if result < "18:00" {
            message = "님, 활기찬 오후 보내세요!"
        } else if result < "22:00" {
            message = "님, 즐거운 저녁 보내고 계신가요?"
        } else {
            message = "님, 굿냣"
        }

        return message
    }
    
    private var onComplete: () -> Void = { }
    
    func product(id: String) -> Product? {
        return products.first(where: { $0.id == id })
    }
    
    func event(id: String) -> Event? {
        return events.first(where: { $0.id == id })
    }
    
    func news(id: String) -> News? {
        return news.first(where: { $0.id == id })
    }
    
    func magazine(id: String) -> Magazine? {
        return magazines.first(where: { $0.id == id })
    }
    
    func fetchProducts() {
        products = [.sample1, .sample2, .sample3, .sample4, .sample5, .sample6]
        events = [.sample1, .sample2]
        news = [.sample1, .sample2]
        magazines = [.sample1, .sample2, .sample3]
        onComplete()
    }
    
    func setOnCompleteAction(_ handler: @escaping () -> Void) {
        onComplete = handler
    }
}
