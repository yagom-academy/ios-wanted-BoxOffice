//
//  Observable.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/03.
//

final class Observable<T> {
    private var listener: ((T) -> Void)?
    
    var value : T {
        didSet {
            self.listener?(value)
        }
    }
    
    init(_ value : T) {
        self.value = value
    }
    
    func bind(_ closure: @escaping (T) -> Void) {
        closure(value)
        self.listener = closure
    }
}
    
