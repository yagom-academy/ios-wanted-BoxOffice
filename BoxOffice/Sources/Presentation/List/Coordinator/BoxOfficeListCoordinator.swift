//
//  BoxOfficeListCoordinator.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import UIKit

final class BoxOfficeListCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var type: CoordinatorType { .list }
    var finishDelegate: CoordinatorFinishDelegate?
    
    init(navigationConrtoller: UINavigationController) {
        self.navigationController = navigationConrtoller
    }
    
    func start() {
        let viewController = makeBoxOfficeListViewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

private extension BoxOfficeListCoordinator {
    
    private func makeBoxOfficeListViewController() -> UIViewController {
        let viewController = BoxOfficeListViewController(
            viewModel: DefaultBoxOfficeListViewModel(),
            coordinator: self
        )
        return viewController
    }
}

extension BoxOfficeListCoordinator: BoxOfficeListCoordinatorInterface {
    
}
