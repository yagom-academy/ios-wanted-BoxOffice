//
//  MovieDetailReviewCellModel.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/22.
//

import Foundation
import UIKit
import Combine

class MovieDetailReviewCellModel {
    // MARK: Input
    
    // MARK: Output
    @Published var review: Review
    @Published var ratingViewModel: RatingViewModel?
    
    // MARK: Properties
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init(review: Review) {
        self.review = review
        bind()
    }
    
    
    // MARK: Binding
    func bind() {
        $review
            .sink(receiveValue: { [weak self] review in
                guard let self else { return }
                self.ratingViewModel = RatingViewModel(rating: review.rating)
            }).store(in: &subscriptions)
    }
}
