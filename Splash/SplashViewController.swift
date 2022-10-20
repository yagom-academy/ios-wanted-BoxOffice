//
//  SplashViewController.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/20.
//

import UIKit

class SplashViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var leaadingConstraint: NSLayoutConstraint!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        
        UIView.animate(withDuration: 2, delay: 0, options: .curveEaseOut) {
            self.leaadingConstraint.constant = -(self.imageView.frame.width - self.view.frame.width)
            self.view.layoutIfNeeded()
        } completion: { _ in
            let mainStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let viewController = mainStoryboard.instantiateInitialViewController()
            UIApplication.shared.keyWindow?.rootViewController = viewController
        }
    }
}
