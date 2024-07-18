//
//  MainTabbarController.swift
//  1SK
//
//  Created by tuyenvx on 12/01/2021.
//

import UIKit

// MARK: UITabBarController
class TabBarController: UITabBarController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setInitTabBarController()
    }
    
    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        let navigation = self.selectedViewController as? BaseNavigationController
        return navigation?.supportedInterfaceOrientations ?? .portrait
    }
    
    override var shouldAutorotate: Bool {
        return true
    }
    
    private func setShadowTabBar() {
        self.tabBar.layer.shadowColor = UIColor.lightGray.cgColor
        self.tabBar.layer.shadowOpacity = 0.5
        self.tabBar.layer.shadowOffset = CGSize.zero
        self.tabBar.layer.shadowRadius = 5
        self.tabBar.layer.borderColor = UIColor.clear.cgColor
        self.tabBar.layer.borderWidth = 0
        self.tabBar.clipsToBounds = false
        self.tabBar.backgroundColor = UIColor.white
    }
    
    // MARK: Init
    private func setInitTabBarController() {
        self.tabBar.layer.borderColor = UIColor.lightGray.cgColor
        self.tabBar.layer.borderWidth = 0.5
        
        UITabBar.appearance().shadowImage = UIImage()
        UITabBar.appearance().backgroundImage = UIImage()
        UITabBar.appearance().barTintColor = UIColor.white
        UITabBar.appearance().backgroundColor = .white
        UITabBar.appearance().tintColor = UIColor(named: "mainColor")
        UITabBar.appearance().unselectedItemTintColor = UIColor.init(hexString: "8A8A8A")
        UITabBar.appearance().isTranslucent = false
        UITabBar.appearance().barStyle = .default
        
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .regular)], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 12, weight: .semibold)], for: .selected)
        
        // MARK: Page 0
        let tab_0 = NewsWireframe().viewController
        tab_0.tabBarItem = TabbarItem.HOME.item
        
        let navigationTab_0 = BaseNavigationController(rootViewController: tab_0)
        navigationTab_0.setHiddenNavigationBarViewControllers([NewsViewController.self])
        
        // MARK: Page 1
        let tab_1 = CarrerBlogRouter.setupModule()
        tab_1.tabBarItem = TabbarItem.CARRER_BLOG.item
        
        let navigaionTab_1 = BaseNavigationController(rootViewController: tab_1)
        navigaionTab_1.setHiddenNavigationBarViewControllers([CarrerBlogViewController.self])
    
        // MARK:  Add Tabbar
        self.viewControllers = [navigationTab_0, navigaionTab_1]
    }
}
