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
    private let superView: UIView?
    
    init(dependency: ActivityDependency, superView: UIView?) {
        self.dependency = dependency
        self.superView = superView
    }
    
    func createActivity() -> UIActivityViewController {
        let activityViewController: UIActivityViewController = UIActivityViewController(activityItems: dependency.actionSet, applicationActivities: nil)
        
        // This lines is for the popover you need to show in iPad
        activityViewController.popoverPresentationController?.sourceView = superView
        
        // This line remove the arrow of the popover to show in iPad
        activityViewController.popoverPresentationController?.permittedArrowDirections = UIPopoverArrowDirection.down
        activityViewController.popoverPresentationController?.sourceRect = CGRect(x: 150, y: 150, width: 0, height: 0)
        
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
