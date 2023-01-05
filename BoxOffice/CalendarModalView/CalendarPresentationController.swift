//
//  CalendarPresentationController.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/04.
//

import UIKit

final class CalendarPresentationController: UIPresentationController {
    private var originalPosition: CGPoint?
    private var currentPositionTouched: CGPoint?
    private let dimmingView: UIView = {
        let dimmingView = UIVisualEffectView(
            effect: UIBlurEffect(style: .systemMaterialDark)
        )
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        return dimmingView
    }()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let size = CGSize(width: UIScreen.main.bounds.width-100,
                          height: UIScreen.main.bounds.height/4)
        let origin = CGPoint(x: 100, y: 50)
        return CGRect(origin: origin, size: size)
    }
    
    override init(presentedViewController: UIViewController,
                  presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController,
                   presenting: presentingViewController)

        presentedView?.autoresizingMask = [
            .flexibleTopMargin,
            .flexibleBottomMargin,
            .flexibleLeftMargin,
            .flexibleRightMargin
        ]

        presentedView?.translatesAutoresizingMaskIntoConstraints = true
    }

    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        let superview = presentingViewController.view!
        superview.addSubview(dimmingView)
        setupDimmingViewLayout(in: superview)
        adoptTapGestureRecognizer()
        dimmingView.alpha = 0
        presentingViewController.transitionCoordinator?.animate(
            alongsideTransition: { _ in
            self.dimmingView.alpha = 0.5
        })
    }
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        
        presentingViewController.transitionCoordinator?.animate(
            alongsideTransition: { _ in
            self.dimmingView.alpha = 0
        }, completion: { _ in
            self.dimmingView.removeFromSuperview()
        })
    }

    private func adoptTapGestureRecognizer() {
        let adoptedView = containerView!
        let tapGestureRecognizer = UITapGestureRecognizer(
            target: self,
            action: #selector(dismissView(_:))
        )
        adoptedView.addGestureRecognizer(tapGestureRecognizer)
    }
    
    private func setupDimmingViewLayout(in view: UIView) {
        NSLayoutConstraint.activate([
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    @objc private func dismissView(_ sender: UITouch) {
        let point = sender.location(in: presentedView)
        if point.y > 235 || point.x < 0{
            presentedViewController.dismiss(animated: true)
        }
    }
}
