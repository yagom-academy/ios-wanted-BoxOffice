//
//  SecondViewControllerRoutable.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import Foundation
import UIKit

protocol SecondViewControllerRoutable: Routable, SecondViewControllerSceneBuildable { }

extension SecondViewControllerRoutable where Self: SecondViewController {
    
    func route(to Scene: SceneCategory) {
        switch Scene {
        case .close:
            self.dismiss(animated: true)
        case .closeWithAction(let scene):
            sendAction(scene: scene)
            self.navigationController?.popViewController(animated: true)
        case .alert:
            guard let scene = buildScene(scene: Scene) else { return }
            guard let nextVC = scene as? UIViewController else { return }
            present(nextVC, animated: true)
        default: break
        }
    }
    
    func sendAction(scene: SceneCategory) {
        switch scene {
        case .main(.firstViewControllerWithAction(let context)):
            // TODO: fix...?
            guard let firstVC = self.navigationController?.viewControllers.first(where: { $0 is FirstViewController }) as? FirstViewController else { return }
            let action = context.dependency
            firstVC.model.didReceiveSceneAction(action)
            break
        default: break
        }
    }
}

protocol SecondViewControllerSceneBuildable: SceneBuildable {
    
}

extension SecondViewControllerSceneBuildable {
    func buildScene(scene: SceneCategory) -> Scenable? {
        var nextScene: Scenable?
        switch scene {
        case .alert(.networkAlert(.normalErrorAlert(let context))):
            nextScene = buildAlert(context: context)
        default: break
        }
        
        return nextScene
    }
}

extension SecondViewControllerSceneBuildable {
    func buildAlert(context: AlertDependency) -> Scenable {
        let nextScene: Scenable
        
        let alert = AlertFactory(dependency: context).createAlert()
        nextScene = alert
        return nextScene
    }
}
