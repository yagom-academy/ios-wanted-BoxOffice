//
//  AlertFactory.swift
//  BoxOffice
//
//  Created by sokol on 2022/10/17.
//

import UIKit

struct AlertActionDependency {
    var title: String?
    var style: UIAlertAction.Style = .default
    var action: ((UIAlertAction) -> ())?
}

struct AlertDependency {
    
    var title: String?
    var message: String?
    var preferredStyle: UIAlertController.Style = .alert
    
    var actionSet: [AlertActionDependency] = []
}

struct AlertFactory {
    
    private let dependency: AlertDependency
    
    init(dependency: AlertDependency) {
        self.dependency = dependency
    }
    
    func createAlert() -> UIAlertController {
        
        let alert = UIAlertController(title: dependency.title, message: dependency.message, preferredStyle: dependency.preferredStyle)
        for action in dependency.actionSet {
            let action = UIAlertAction(title: action.title, style: action.style, handler: action.action)
            alert.addAction(action)
        }
        return alert
    }
    
}
