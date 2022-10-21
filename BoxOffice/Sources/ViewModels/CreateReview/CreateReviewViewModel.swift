//
//  CreateReviewViewModel.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/21.
//

import Foundation
import UIKit
import Combine

class CreateReviewViewModel {
    // MARK: Subjects
    let viewAction = PassthroughSubject<ViewAction, Never>()
    
    // MARK: Output
    @Published var movie: Movie
    
    // MARK: Properties
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init(movie: Movie) {
        self.movie = movie
        bind()
    }
    
    
    // MARK: Binding
    func bind() {

    }
    
    enum ViewAction {
        case dismiss
    }
}
