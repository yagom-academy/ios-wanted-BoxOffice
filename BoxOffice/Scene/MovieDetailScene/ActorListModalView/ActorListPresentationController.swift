//
//  ActorListPresentationController.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/06.
//

import UIKit

final class ActorListPresentationController: UIPresentationController {
    private var originalPosition: CGPoint = CGPoint(x: 0, y: 0)
    private var currentPositionTouched: CGPoint?
    private let viewWidth = UIScreen.main.bounds.width / 2
    private let viewHeight = UIScreen.main.bounds.height / 3
    
    private let dimmingView: UIView = {
        let dimmingView = UIVisualEffectView(
            effect: UIBlurEffect(style: .systemMaterialDark)
        )
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        return dimmingView
    }()
    
    override var frameOfPresentedViewInContainerView: CGRect {
        let size = CGSize(width: viewWidth,
                          height: viewHeight)
        let origin = CGPoint(
            x: UIScreen.main.bounds.midX-viewWidth / 2,
            y: UIScreen.main.bounds.midY-viewHeight / 2
        )
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
        guard let adoptedView = containerView else { return }
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
        if point.y < 0 || point.y > viewHeight || point.x < 0 || point.x > viewWidth {
            presentedViewController.dismiss(animated: true)
        }
    }
}
