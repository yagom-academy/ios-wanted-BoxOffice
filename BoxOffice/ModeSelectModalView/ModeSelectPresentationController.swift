//
//  ModeSelectPresentationController.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/04.
//

import UIKit

final class ModeSelectPresentationController: UIPresentationController {
    private var originalPosition: CGPoint = CGPoint(x: 0, y: 0)
    private var currentPositionTouched: CGPoint?
    private let dimmingView: UIView = {
        let dimmingView = UIVisualEffectView(
            effect: UIBlurEffect(style: .systemMaterialDark)
        )
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        return dimmingView
    }()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let size = CGSize(width: UIScreen.main.bounds.width,
                          height: UIScreen.main.bounds.height/4)
        let origin = CGPoint(x: 0, y: (UIScreen.main.bounds.height*3)/4)
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
        
        guard let superview = presentingViewController.view else { return }
        superview.addSubview(dimmingView)
        setupDimmingViewLayout(in: superview)
        adoptPanGestureRecognizer()
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

    private func adoptPanGestureRecognizer() {
        guard let adoptedView = containerView else { return }
        let panGestureRecognizer = UIPanGestureRecognizer(
            target: self,
            action: #selector(dismissView(_:))
        )
        adoptedView.addGestureRecognizer(panGestureRecognizer)
    }
    
    private func setupDimmingViewLayout(in view: UIView) {
        NSLayoutConstraint.activate([
            dimmingView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            dimmingView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            dimmingView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            dimmingView.topAnchor.constraint(equalTo: view.topAnchor)
        ])
    }
    
    @objc private func dismissView(_ sender: UIPanGestureRecognizer) {
        guard let presentedView = presentedView else { return }
        let translation = sender.translation(in: presentedView)
        
        if sender.state == .began {
            originalPosition = presentedView.center
            currentPositionTouched = sender.location(in: presentedView)
        } else if sender.state == .changed {
            
            if presentedView.frame.origin.y < 680 {
                return
            }
            presentedView.center.y = originalPosition.y + translation.y*0.1
        } else if sender.state == .ended {
            let velocity = sender.velocity(in: presentedView)
            
            if velocity.y >= 100 {
                presentedViewController.dismiss(animated: true)
            } else {
                UIView.animate(withDuration: 0.2) { [self] in
                    presentedView.center = originalPosition
                }
            }
        }
    }
}
