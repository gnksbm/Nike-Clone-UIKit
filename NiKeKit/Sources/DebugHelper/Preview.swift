//
//  Preview.swift
//  NiKeKit
//
//  Created by gnksbm on 2023/09/05.
//

import SwiftUI

struct UIKitPreview: UIViewControllerRepresentable {
    var selectedIndex: Int
    private let tc = UITabBarController()
    
    func makeUIViewController(context: Context) -> some UIViewController {
        tc.viewControllers = MainTab.makeAllCasesToViewControllers()
        tc.selectedIndex = selectedIndex
        return tc
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
}
