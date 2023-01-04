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
        let rootViewController = MovieDetailViewController(movieOverview: MovieOverview(movieCode: "20228829", dayType: .weekdays, region: .Seoul, rank: 1, title: "아바타", openingDay: Date(), audienceNumber: 2000, rankFluctuation: 1, isNewlyRanked: true))
        window?.rootViewController = UINavigationController(rootViewController: rootViewController)
        window?.makeKeyAndVisible()
        return true
    }
}

