//
//  TabbarItem.swift
//  1SK
//
//  Created by tuyenvx on 20/01/2021.
//

import UIKit

// MARK: UITabBar
extension UITabBar {
    func addBadge(index: Int) {
        if let tabItems = self.items {
            let tabItem = tabItems[index]
            tabItem.badgeValue = "●"
            tabItem.badgeColor = .clear
            tabItem.setBadgeTextAttributes([NSAttributedString.Key.foregroundColor: UIColor.red], for: .normal)
        }
    }
    
    func removeBadge(index: Int) {
        if let tabItems = self.items {
            let tabItem = tabItems[index]
            tabItem.badgeValue = nil
        }
    }
 }

// MARK: TabbarItem
enum TabbarItem {
    case HOME
    case CHATAI

    var item: UITabBarItem {
        switch self {
        case .HOME:
            let tabBarItem = UITabBarItem()
            tabBarItem.tag = 0
            tabBarItem.title  = "Home"
            tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -1)
            tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            tabBarItem.image = self.tabbarImage(with: UIImage(named: "ic_home"))
            tabBarItem.selectedImage = self.tabbarImage(with: UIImage(named: "ic_home_selected"))
            
            return tabBarItem
            
        case .CHATAI:
            let tabBarItem = UITabBarItem()
            tabBarItem.tag = 2
            tabBarItem.title  = "CHAT AI"
            tabBarItem.titlePositionAdjustment = UIOffset(horizontal: 0, vertical: -1)
            tabBarItem.imageInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            
            return tabBarItem
        }
    }

    private func tabbarImage(with image: UIImage?) -> UIImage? {
        return image?.withRenderingMode(.alwaysOriginal)
    }
}
