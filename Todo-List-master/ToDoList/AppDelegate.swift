//
//  AppDelegate.swift
//  ToDoList
//
//  Created by Creo Server on 24/06/20.
//  Copyright © 2020 Anant Server. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        //setting up window
        window = UIWindow(frame: UIScreen.main.bounds)
        //to show the current window and position it in front of all other windows at the same level or lower
        window?.makeKeyAndVisible()
        
        let vc = ToDoListViewController()
        window?.rootViewController = UINavigationController(rootViewController: vc)
        
        return true
    }

}

