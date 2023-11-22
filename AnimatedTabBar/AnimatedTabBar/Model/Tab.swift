//
//  Tab.swift
//  AnimatedTabBar
//
//  Created by Ilya Bondarenko on 22.11.2023.
//

import Foundation

/// Tab's
enum Tab: String, CaseIterable {
    case dashboard = "house"
    case list = "list.bullet.rectangle.portrait"
    case notifications = "bell.badge"
    case favorites = "heart"
    case settings = "gearshape"
    
    var title: String {
        switch self {
        case .dashboard:
            return "Dashboard"
        case .list:
            return "List"
        case .notifications:
            return "Notifications"
        case .favorites:
            return "Favorites"
        case .settings:
            return "Settings"
        }
    }
}

struct AnimatedTab: Identifiable {
    var id: UUID = .init()
    var tab: Tab
    var isAnimating: Bool?
}
