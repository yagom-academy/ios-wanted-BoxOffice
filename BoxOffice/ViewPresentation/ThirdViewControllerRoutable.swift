//
//  ThirdViewControllerRoutable.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import Foundation
import UIKit

protocol ThirdViewControllerRoutable: Routable, ThirdViewControllerSceneBuildable {
    
}
    
extension ThirdViewControllerRoutable where Self: ThirdViewController {
    func buildScene(scene: SceneCategory) -> Scenable? {
        var nextScene: Scenable?
        switch scene {
        case .alert(let context):
            nextScene = buildAlert(context: context)
        default: break
        }
        return nextScene
    }
    
    func route(to Scene: SceneCategory) {
        switch Scene {
        case .close:
            self.navigationController?.popViewController(animated: true)
        case .alert:
            guard let scene = buildScene(scene: Scene) else { return }
            guard let nextVC = scene as? UIViewController else { return }
            present(nextVC, animated: true)
        default: break
        }
    }
}

protocol ThirdViewControllerSceneBuildable: SceneBuildable {
    
}

extension ThirdViewControllerSceneBuildable {
    func buildAlert(context: AlertDependency) -> Scenable {
        let nextScene: Scenable
        
        let alert = AlertFactory(dependency: context).createAlert()
        nextScene = alert
        return nextScene
    }
}
