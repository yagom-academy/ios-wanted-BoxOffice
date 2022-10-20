//
//  MovieDetailViewModel.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/20.
//

import Foundation
import UIKit
import Combine

class MovieDetailViewModel {
    // MARK: Input
    
    // MARK: Output
    @Published var movie: Movie
    let viewAction = PassthroughSubject<ViewAction, Never>()
    
    // MARK: Properties
    
    
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
        case share
    }
}
