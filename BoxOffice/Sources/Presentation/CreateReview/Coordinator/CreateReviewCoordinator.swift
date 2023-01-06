//
//  CreateReviewCoordinator.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/04.
//

import UIKit

final class CreateReviewCoordinator: Coordinator {
    
    var parentCoordinator: Coordinator?
    var childCoordinators: [Coordinator] = []
    var navigationController: UINavigationController
    var type: CoordinatorType { .review }
    weak var finishDelegate: CoordinatorFinishDelegate?
    
    init(navigationConrtoller: UINavigationController) {
        self.navigationController = navigationConrtoller
    }
    
    func start() {
        let viewController = makeCreateReviewController()
        navigationController.pushViewController(viewController, animated: true)
    }
    
}

private extension CreateReviewCoordinator {
    
    func makeCreateReviewController() -> UIViewController {
        let viewController = CreateReviewViewController(
            viewModel: DefaultCreateReviewViewModel(),
            coordinator: self
        )
        return viewController
    }
    
    func makeImagePickerController(_ viewController: UIViewController) -> UIImagePickerController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = viewController as? any UIImagePickerControllerDelegate & UINavigationControllerDelegate
        imagePicker.allowsEditing = true
        return imagePicker
    }
}

extension CreateReviewCoordinator: CreateReviewCoordinatorInterface {
    
    func finish() {
        parentCoordinator = nil
        finishDelegate?.coordinatorDidFinish(childCoordinator: self)
    }
    
    func showImagePicker(_ viewController: UIViewController) {
        let viewController = makeImagePickerController(viewController)
        navigationController.visibleViewController?.present(viewController, animated: true)
    }
    
}
