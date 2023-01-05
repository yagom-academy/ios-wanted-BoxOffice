//
//  CalendarTransitioningDelegate.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/04.
//

import UIKit

final class CalendarTransitioningDelegate: NSObject, UIViewControllerTransitioningDelegate {
    
    func presentationController(forPresented presented: UIViewController,
                                presenting: UIViewController?,
                                source: UIViewController) -> UIPresentationController? {
        return CalendarPresentationController(
            presentedViewController: presented,
            presenting: presenting
        )
    }
}
