//
//  AppDelegate.swift
//  CBFlashyTabBarController
//
//  Created by askopin@gmail.com on 11/29/2018.
//  Copyright (c) 2018 askopin@gmail.com. All rights reserved.
//

import UIKit
import VpsvilleUIController

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication,
                     didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
//        window = UIWindow(frame: UIScreen.main.bounds)
//        window?.makeKeyAndVisible()
//        window?.rootViewController = UINavigationController(rootViewController: LoginViewController())
        CBTabBar.appearance().tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1) //UIColor(red: 16.0/255.0, green: 224.0/255.0, blue: 223.0/255.0, alpha: 1.0)
        CBTabBar.appearance().barTintColor = #colorLiteral(red: 0.2, green: 0.6, blue: 1, alpha: 1)
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
    }

    func applicationDidEnterBackground(_ application: UIApplication) {

    }

    func applicationWillEnterForeground(_ application: UIApplication) {

    }

    func applicationDidBecomeActive(_ application: UIApplication) {

    }

    func applicationWillTerminate(_ application: UIApplication) {

    }

}
