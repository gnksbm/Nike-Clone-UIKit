//
//  User.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import UIKit

struct User {
    let id: String
    var image: UIImage?
    var firstName: String
    var lastName: String
    var address: String?
    var introducing: String?
    let joinedAt: Date
    
    init(id: String = UUID().uuidString,
         image: UIImage? = nil,
         firstName: String,
         lastName: String,
         address: String? = nil,
         introducing: String? = nil,
         joinedAt: Date = Date()) {
        self.id = id
        self.image = image
        self.firstName = firstName
        self.lastName = lastName
        self.address = address
        self.introducing = introducing
        self.joinedAt = joinedAt
    }
}

extension User {
    var fullName: String {
        lastName + firstName
    }
}

extension User {
    static let sample1: Self = .init(firstName: "건섭", lastName: "김")
}
