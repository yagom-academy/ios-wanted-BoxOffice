//
//  CreateReviewRatingViewModel.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/21.
//

import Foundation
import UIKit
import Combine

class CreateReviewRatingViewModel {
    // MARK: Input
    
    // MARK: Output
    @Published var ratingViewModel = RatingViewModel()
    @Published var rating: Int = 0
    
    // MARK: Properties
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init() {
        bind()
    }
    
    
    // MARK: Binding
    func bind() {
        ratingViewModel.$rating
            .sink(receiveValue: { [weak self] rating in
                guard let self else { return }
                self.rating = rating
            }).store(in: &subscriptions)
    }
}
