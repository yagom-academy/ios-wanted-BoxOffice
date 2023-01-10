//
//  AppCoordinator.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import UIKit

final public class AppCoordinator: Coordinator {
    
    var type: CoordinatorType { .root }
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    public init(navigationConrtoller: UINavigationController) {
        self.navigationController = navigationConrtoller
    }
    
    public func start() {
        let coordinator = makeMotionListCoordinator()
        coordinator.start()
    }
    
}

private extension AppCoordinator {
    
    private func makeMotionListCoordinator() -> Coordinator {
        let coordinator = BoxOfficeListCoordinator(navigationConrtoller: navigationController)
        coordinator.parentCoordinator = self
        childCoordinators.append(coordinator)
        
        return coordinator
    }
    
}
