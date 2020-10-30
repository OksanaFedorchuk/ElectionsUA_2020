//
//  AppDelegate.swift
//  VYBORY
//
//  Created by Oksana Fedorchuk on 19.10.2020.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        moveDB()
        return true
    }
    
    func moveDB() {
        let fileManager = FileManager.default
        let documentsDirectory = fileManager.urls(for: .documentDirectory, in: .userDomainMask).first!
        guard let sourcePath = Bundle.main.path(forResource: "code", ofType: "db") else {
            return
        }
        
        if fileManager.fileExists(atPath: sourcePath) {
            let sourceUrl = URL(fileURLWithPath: sourcePath)
            let destination = documentsDirectory.appendingPathComponent("code.db", isDirectory: false)
            try? fileManager.copyItem(at: sourceUrl, to: destination)
            
            if fileManager.fileExists(atPath: destination.path) {
                print("file copied")
            } else {
                print("file copy failed")
            }
        }
    }
    
    // MARK: UISceneSession Lifecycle
    
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }
    
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }
    
    
}

