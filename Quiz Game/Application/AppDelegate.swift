//
//  AppDelegate.swift
//  Quiz Game
//
//  Created by APPLE on 08.07.2022.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        CoreDataManager.shared.load {
            let launchedBefore = UserDefaults.standard.bool(forKey: "launchedBefore")

            if launchedBefore {
                debugPrint("launchedBefore")

            } else {
                UserDefaults.standard.set(true, forKey: "launchedBefore")
                UserDefaultsManager.shared.firstLaunch()
                CoreDataManager.shared.firstLaunch()
            }
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        CoreDataManager.shared.save()
    }
}

