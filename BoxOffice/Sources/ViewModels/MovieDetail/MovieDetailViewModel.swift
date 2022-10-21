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
    @Published var posterModel: MoviePosterViewModel?
    let viewAction = PassthroughSubject<ViewAction, Never>()
    
    // MARK: Properties
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init(movie: Movie) {
        self.movie = movie
        bind()
    }
    
    // MARK: Binding
    func bind() {
        $movie
            .sink(receiveValue: { [weak self] movie in
                guard let self else { return }
                self.posterModel = MoviePosterViewModel(movie: movie)
            }).store(in: &subscriptions)
    }
    
    enum ViewAction {
        case dismiss
        case share
    }
}
