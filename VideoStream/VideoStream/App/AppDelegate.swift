//
//  AppDelegate.swift
//  VideoStream
//
//  Created by Sharon Omoyeni Babatunde on 07/11/2022.
//

import UIKit
import Firebase

@available(iOS 13.0, *)
@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        let window = UIWindow(frame: UIScreen.main.bounds)
        setUpRootViewController(window: window)
        return true
    }

    func setUpRootViewController(window: UIWindow) {
        let storyboard = UIStoryboard(name: "MainViewController", bundle: nil)
        let mainViewController = storyboard.instantiateViewController(withIdentifier: "MainViewController")
        let navController = UINavigationController(rootViewController: mainViewController)
        window.rootViewController = navController
        window.makeKeyAndVisible()
        self.window = window
    }
    
    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }


}

