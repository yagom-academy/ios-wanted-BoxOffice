//
//  AppDelegate.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.rootViewController = UINavigationController(rootViewController: BoxOfficeListViewController())
        window?.makeKeyAndVisible()
        return true
    }
}
