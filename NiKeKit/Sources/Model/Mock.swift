//
//  Mock.swift
//  MusicAPIUI
//
//  Created by gnksbm on 2023/08/14.
//

import UIKit

// MARK: - Welcome
struct Mock: Codable {
    let resultCount: Int
    let results: [MockResult]
}

// MARK: - Result
struct MockResult: Codable {
    let id: Int?
    let title: String?
    let imageURLStr: String

    enum CodingKeys: String, CodingKey {
        case id = "trackId"
        case title = "trackName"
        case imageURLStr = "artworkUrl100"
    }
}

extension Array<MockResult> {
    var stringIDs: [String] {
        let ids: [String] = compactMap {
            guard let int = $0.id else { return nil }
            return String(int)
        }
        return ids
    }
    
    func convertToNews() async -> [News] {
        var newsList = [News]()
        await self.asyncForEach { mock in
            guard let url = URL(string: mock.imageURLStr),
                  let title = mock.title else { return }
            let result = await NetworkManager.shared.fetchData(url: url)
            switch result {
            case .success(let data):
                newsList.append(News(image: UIImage(data: data), title: title, subtitle: "", interaction: ""))
            case .failure(let error):
                print(#function, error.localizedDescription)
            }
        }
        return newsList
    }
}
