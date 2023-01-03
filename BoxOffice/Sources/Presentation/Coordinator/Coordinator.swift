//
//  Coordinator.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import UIKit

protocol Coordinator: AnyObject {
    
    var parentCoordinator: Coordinator? { get set }
    var childCoordinators: [Coordinator] { get set }
    var navigationController: UINavigationController { get set }
    var type: CoordinatorType { get }
    var finishDelegate: CoordinatorFinishDelegate? { get set }
    func start()

}

extension Coordinator {
    func childDidFinish(_ child: Coordinator?, parent: Coordinator?) {
        guard let parent = parent,
              parent.childCoordinators.isEmpty == false else {
            return
        }
        
        for (index, coordinator) in parent.childCoordinators.enumerated() where coordinator === child {
            parent.childCoordinators.remove(at: index)
            break
        }
    }
}

protocol CoordinatorFinishDelegate: AnyObject {
    func coordinatorDidFinish(childCoordinator: Coordinator)
}

enum CoordinatorType {
    case root
    case list
}
