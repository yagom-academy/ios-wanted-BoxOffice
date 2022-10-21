//
//  ActivityViewControllerFactory.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/21.
//

import UIKit

struct ActivityDependency {
    var actionSet: [Any] = []
}

struct ActivityFactory {
    private let dependency: ActivityDependency
    
    init(dependency: ActivityDependency) {
        self.dependency = dependency
    }
    
    func createActivity() -> UIActivityViewController {
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: dependency.actionSet, applicationActivities: nil)
        
        activityViewController.activityItemsConfiguration = [
            UIActivity.ActivityType.message
        ] as? UIActivityItemsConfigurationReading
        
        activityViewController.excludedActivityTypes = [
            UIActivity.ActivityType.postToWeibo,
            UIActivity.ActivityType.print,
            UIActivity.ActivityType.assignToContact,
            UIActivity.ActivityType.saveToCameraRoll,
            UIActivity.ActivityType.addToReadingList,
            UIActivity.ActivityType.postToFlickr,
            UIActivity.ActivityType.postToVimeo,
            UIActivity.ActivityType.postToTencentWeibo,
            UIActivity.ActivityType.postToFacebook
        ]
        activityViewController.isModalInPresentation = true
        return activityViewController
    }
}
