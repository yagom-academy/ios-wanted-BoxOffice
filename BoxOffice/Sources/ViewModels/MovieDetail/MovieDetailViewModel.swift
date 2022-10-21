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
    // MARK: Subject
    let share = PassthroughSubject<Void, Never>()
    let createReview = PassthroughSubject<Void, Never>()
    let viewAction = PassthroughSubject<ViewAction, Never>()
    
    // MARK: Output
    @Published var movie: Movie
    @Published var posterModel: MoviePosterViewModel?
    @Published var directorModel: TriSectoredStackViewModel?
    @Published var actorModel: TriSectoredStackViewModel?
    @Published var reviews = [Review]()
    @Published var averageRatingViewModel: RatingViewModel?
    @Published var reviewCellModels: [MovieDetailReviewCellModel]?
    
    // MARK: Properties
    let repository = Repository()
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
                if let directors = movie.detailInfo?.directors {
                    self.directorModel = TriSectoredStackViewModel(list: directors)
                }
                if let actors = movie.detailInfo?.actors {
                    self.actorModel = TriSectoredStackViewModel(list: actors)
                }
            }).store(in: &subscriptions)
        
        $movie
            .prefix(1)
            .flatMap { [weak self] movie -> AnyPublisher<[Review], Error> in
                guard let self else { return Empty().eraseToAnyPublisher() }
                return self.repository.getMovieReviews(movie.movieCode)
            }.sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    debugPrint("😡Error Occured While Fetching Review: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] reviews in
                guard let self else { return }
                self.reviews = reviews
                var averageRating: Int
                if reviews.count > 0 {
                    averageRating = reviews.map { $0.rating }.reduce(0, +) / reviews.count
                } else {
                    averageRating = 0
                }
                self.averageRatingViewModel = RatingViewModel(rating: averageRating)
                self.reviewCellModels = self.reviews.map { MovieDetailReviewCellModel(review: $0) }
            }).store(in: &subscriptions)
        
        share
            .compactMap { [weak self] _ in
                guard let self else { return nil }
                return .share(self.movie.prettify())
            }.subscribe(viewAction)
            .store(in: &subscriptions)
        
        createReview
            .compactMap { [weak self] _ in
                guard let self else { return nil }
                let vc = CreateReviewViewController()
                vc.viewModel = CreateReviewViewModel(movie: self.movie)
                return ViewAction.push(vc)
            }.subscribe(viewAction)
            .store(in: &subscriptions)
    }
    
    enum ViewAction {
        case dismiss
        case share(String)
        case push(_ vc: UIViewController)
    }
}
