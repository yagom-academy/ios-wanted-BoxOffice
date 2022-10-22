//
//  ControlEventPublisher.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/20.
//

import Foundation
import UIKit
import Combine

extension UIControl {
    func controlEvent(_ event: UIControl.Event) -> UIControlEventPublihser {
        return .init(uiControl: self, event: event)
    }
}

struct UIControlEventPublihser: Publisher {
    typealias Output = Void
    typealias Failure = Never
    
    private let uiControl: UIControl
    private let event: UIControl.Event
    
    init(uiControl: UIControl, event: UIControl.Event) {
        self.uiControl = uiControl
        self.event = event
    }
    
    func receive<S>(subscriber: S) where S : Subscriber, Never == S.Failure, Void == S.Input {
        let subscription = UIControlEventSubscription(
            subscriber: subscriber,
            uiControl: uiControl,
            event: event)
        subscriber.receive(subscription: subscription)
    }
}

class UIControlEventSubscription<S: Subscriber>: Subscription where S.Input == Void, S.Failure == Never {
    private var subscriber: S?
    private var uiControl: UIControl
    private var event: UIControl.Event
    
    init(subscriber: S? = nil, uiControl: UIControl, event: UIControl.Event) {
        self.subscriber = subscriber
        self.uiControl = uiControl
        self.event = event
        
        uiControl.addTarget(self, action: #selector(handle), for: event)
    }
    
    func request(_ demand: Subscribers.Demand) { }
    
    func cancel() {
        subscriber = nil
        self.uiControl.removeTarget(self, action: #selector(handle), for: event)
    }
    
    @objc func handle() {
        _ = subscriber?.receive(())
    }
}
