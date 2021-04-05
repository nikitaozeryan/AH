//
//  AppDelegate.swift
//  AH
//
//  Created by Nikita Ozerian on 05.04.2021.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    private lazy var platform = Platform()
    private lazy var appCoordinator = AppCoordinator(useCases: platform)
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        window = appCoordinator.window
        return true
    }
}

