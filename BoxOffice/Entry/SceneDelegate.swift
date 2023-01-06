//
//  SceneDelegate.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(
        _ scene: UIScene,
        willConnectTo session: UISceneSession,
        options connectionOptions: UIScene.ConnectionOptions
    ) {
        guard let windowScene = (scene as? UIWindowScene) else { return }
        
        window = UIWindow(windowScene: windowScene)
        let box = DetailBoxOffice(movieCode: "1111", productionYear: "2222", openDate: "3333", showTime: "4444", genreName: "5555", dirctors: "6666", actors: "7777", watchGradeName: "8888", movieEnglishName: "9999")
        let viewModel = CommentAddViewModel(detailBoxOffice: box)
        window?.rootViewController = UINavigationController(
            rootViewController: CommentViewController(viewModel: viewModel)
        )
        window?.backgroundColor = .white
        window?.overrideUserInterfaceStyle = .light
        window?.makeKeyAndVisible()
    }

    func sceneDidDisconnect(_ scene: UIScene) {}
    func sceneDidBecomeActive(_ scene: UIScene) {}
    func sceneWillResignActive(_ scene: UIScene) {}
    func sceneWillEnterForeground(_ scene: UIScene) {}
    func sceneDidEnterBackground(_ scene: UIScene) {}
}

