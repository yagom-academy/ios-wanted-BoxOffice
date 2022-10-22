//
//  ViewGesturePublisher.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/21.
//

import Foundation
import UIKit
import Combine


extension UIView {
    func gesture(_ type: GestureType = .tap) -> UIViewGesturePublisher {
        return .init(view: self, gestureType: type)
    }
}

struct UIViewGesturePublisher: Publisher {
    typealias Output = UIGestureRecognizer
    typealias Failure = Never
    
    private let view: UIView
    private let gestureType: GestureType
    
    init(view: UIView, gestureType: GestureType) {
        self.view = view
        self.gestureType = gestureType
    }
    
    func receive<S>(subscriber: S) where S: Subscriber, Never == S.Failure, UIGestureRecognizer == S.Input {
        let subscription = UIViewGestureSubscription(
            subscriber: subscriber,
            view: view,
            gestureType: gestureType)
        subscriber.receive(subscription: subscription)
    }
}

class UIViewGestureSubscription<S: Subscriber>: Subscription where S.Input == UIGestureRecognizer, S.Failure == Never {
    private var subscriber: S?
    private var gestureRecognizer: UIGestureRecognizer
    private var view: UIView
    
    init(subscriber: S? = nil, view: UIView, gestureType: GestureType) {
        self.subscriber = subscriber
        self.view = view
        
        gestureRecognizer = gestureType.gestureRecognizer()
        gestureRecognizer.addTarget(self, action: #selector(handle))
        self.view.addGestureRecognizer(gestureRecognizer)
        
    }
    
    func request(_ demand: Subscribers.Demand) { }
    
    func cancel() {
        subscriber = nil
        self.view.removeGestureRecognizer(gestureRecognizer)
    }
    
    @objc func handle() {
        _ = subscriber?.receive(gestureRecognizer)
    }
}

enum GestureType {
    case tap
    case pan
    
    func gestureRecognizer() -> UIGestureRecognizer {
        switch self {
        case .tap: return UITapGestureRecognizer()
        case .pan: return UIPanGestureRecognizer()
        }
    }
}
