//
//  BoxOfficeApp.swift
//  BoxOffice
//
//  Created by brad on 2023/01/03.
//

import SwiftUI
import FirebaseCore

class AppDelegate: NSObject, UIApplicationDelegate {
  func application(_ application: UIApplication,
                   didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
    return true
  }
}

@main
struct BoxOfficeApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            BoxOfficeMainView()
                .environmentObject(BoxOfficeMainViewModel())
        }
    }
}
