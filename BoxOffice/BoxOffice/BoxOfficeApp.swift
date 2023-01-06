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
    
    init() {
        let firestoreManager = BoxOfficeFirebaseStorageManager()
        let testReview = Review(
            nickname: "보리2",
            password: "4321",
            description: "asdf",
            starRank: 3,
            images: [UIImage(systemName: "mic")!.pngData()!, UIImage(systemName: "mic")!.pngData()!]
        )
        
        firestoreManager.createData(review: testReview)
        
        let fetchedReview = firestoreManager.fetchReviewList(nickName: "보리") { review in
            print("--")
            print(review.nickname)
            print(review.description)
            print(review.images[0].self)
        }
        
    }
    
    var body: some Scene {
        WindowGroup {
            BoxOfficeMainView()
                .environmentObject(BoxOfficeMainViewModel())
        }
    }
}
