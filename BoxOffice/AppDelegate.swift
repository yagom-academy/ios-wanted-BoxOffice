//
//  AppDelegate.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit
import FirebaseCore

@main
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        window = UIWindow(frame: UIScreen.main.bounds)
        let rootViewController = ViewController()
        window?.rootViewController = rootViewController
        window?.makeKeyAndVisible()
        return true
    }
}

