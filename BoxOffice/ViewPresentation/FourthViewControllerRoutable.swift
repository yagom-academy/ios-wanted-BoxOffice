//
//  FourthViewControllerRoutable.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/22.
//

import Foundation
import UIKit

protocol FourthViewContollerRoutable: Routable { }

extension FourthViewContollerRoutable where Self: FourthViewController {
    
    func route(to Scene: SceneCategory) {
        switch Scene {
        case .main(.firstViewControllerWithAction):
            sendAction(scene: Scene)
            self.dismiss(animated: true, completion: nil)
        default:
            break
        }
    }
    
    func sendAction(scene: SceneCategory) {
        switch scene {
        case .main(.firstViewControllerWithAction(let context)):
            guard let presentingNavi = self.presentingViewController as? UINavigationController else { return }
            guard let firstVC = presentingNavi.viewControllers.first(where: { $0 is FirstViewController }) as? FirstViewController else { return }
            let action = context.dependency
            firstVC.model.didReceiveSceneAction(action)
            break
        default: break
        }
    }
}
