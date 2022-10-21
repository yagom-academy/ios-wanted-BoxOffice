//
//  RatingViewModel.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/21.
//

import Foundation
import UIKit
import Combine

class RatingViewModel {
    // MARK: Input
    
    // MARK: Output
    @Published var rating: Int = 0
    
    // MARK: Properties
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init() {
        bind()
    }
    
    
    // MARK: Binding
    func bind() {

    }
}
