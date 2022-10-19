//
//  FirstViewControllerRoutable.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import UIKit

protocol FirstViewControllerRoutable: Routable, FirstViewControllerSceneBuildable {
    
}

extension FirstViewControllerRoutable where Self: FirstViewController {
    func route(to Scene: SceneCategory) {
        switch Scene {
        case .main(_):
            break
        case .detail(.secondViewController(let context)):
            guard let nextScene = buildSecondScene(context: context) as? UIViewController else { return }
            self.navigationController?.pushViewController(nextScene, animated: true)
        case .close:
            break
        case .closeWithAction(_):
            break
        case .alert:
            let nextScene = buildScene(scene: Scene)
            guard let nextVC = nextScene as? UIViewController else { return }
            self.present(nextVC, animated: true)
        default: break
        }
    }
}

protocol FirstViewControllerSceneBuildable: SceneBuildable { }

extension FirstViewControllerSceneBuildable {
    
    func buildSecondScene(context: SceneContext<SecondModel>) -> Scenable {
        var nextScene: Scenable
        let secondModel = context.dependency
        let secondVC = SecondViewController(viewModel: secondModel)
        nextScene = secondVC
        
        return nextScene
    }
    
    func buildAlert(context: AlertDependency) -> Scenable {
        let nextScene: Scenable
        
        let alert = AlertFactory(dependency: context).createAlert()
        nextScene = alert
        return nextScene
    }
}

extension FirstViewControllerSceneBuildable {
    func buildScene(scene: SceneCategory) -> Scenable? {
        var nextScene: Scenable?
        switch scene {
        case .main(.firstViewController(_)):
             break
        case .detail(.secondViewController(let context)):
            nextScene = buildSecondScene(context: context)
        case .close:
            break
        case .closeWithAction(_):
            break
        case .alert(.networkAlert(.normalErrorAlert(let context))):
           nextScene = buildAlert(context: context)
        default: break
        }
        
        return nextScene
    }
}
