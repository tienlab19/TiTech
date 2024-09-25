//
//  AppDelegate.swift
//  TiTech
//
//  Created by Apple on 9/7/24.
//

import UIKit
import FirebaseCore
import AppCenter
import AppCenterAnalytics
import AppCenterCrashes

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        //MARK: - Firebase Configure
        FirebaseApp.configure()
        configureAppCenter()
        return true
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) { }
}

extension AppDelegate {
    private func configureAppCenter() {
        AppCenter.start(withAppSecret: AppConstants.APPCENTER_API_KEY, services:[
          Analytics.self,
          Crashes.self
        ])
    }
}

