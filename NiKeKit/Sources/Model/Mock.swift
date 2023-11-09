//
//  Mock.swift
//  MusicAPIUI
//
//  Created by gnksbm on 2023/08/14.
//

import Foundation

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
}
