//
//  AppDelegate.swift
//  FinanceFusion
//
//  Created by Öykü Hazer Ekinci on 29.08.2023.
//

import UIKit
import Firebase

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure() 
      
              let backImage = UIImage(named: "backIcon")
              UINavigationBar.appearance().backIndicatorImage = backImage
              UINavigationBar.appearance().backIndicatorTransitionMaskImage = backImage
              UINavigationBar.appearance().tintColor = UIColor.white
              UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffset(horizontal: -UIScreen.main.bounds.width, vertical: 0), for: .default)
              
        return true
    }

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
      
    }
}
