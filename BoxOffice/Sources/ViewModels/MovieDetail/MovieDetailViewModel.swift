//
//  MovieDetailViewModel.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/20.
//

import Foundation
import UIKit
import Combine
import FirebaseStorage

class MovieDetailViewModel {
    // MARK: Subject
    let share = PassthroughSubject<Void, Never>()
    let createReview = PassthroughSubject<Void, Never>()
    let deleteReview = PassthroughSubject<Review, Never>()
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
        
        let movieSubscription = $movie.map { _ in }.prefix(1)
        let reviewCreated = NotificationCenter.default.publisher(for: .reviewCreated)
            .compactMap { $0.userInfo?["movieCode"] as? String }
            .filter { [weak self] movieCode in
                return self?.movie.movieCode == movieCode
            }
            .map { _ in }
        
        movieSubscription
            .merge(with: reviewCreated)
            .handleEvents(receiveOutput: { [weak self] _ in
                self?.reviewCellModels = []
            })
            .flatMap { [weak self] _ -> AnyPublisher<[Review], Error> in
                guard let self else { return Empty().eraseToAnyPublisher() }
                return self.repository.getMovieReviews(self.movie.movieCode)
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
                let viewModels = self.reviews.map { MovieDetailReviewCellModel(review: $0) }
                viewModels.forEach { self.bindReviewCellModel($0) }
                self.reviewCellModels = viewModels
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
        
        deleteReview
            .flatMap { [weak self] review -> AnyPublisher<StorageMetadata, Error> in
                guard let self else { return Empty().eraseToAnyPublisher() }
                self.reviews.removeAll(where: { $0 == review })
                self.reviewCellModels?.removeAll(where: { $0.review == review })
                return self.repository.deleteMovieReview(self.movie.movieCode, review: review)
            }.sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    debugPrint("😡Error Occured While Deleting Review: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] _ in
                guard let self else { return }
                let alert = UIAlertController(title: "", message: "리뷰가 삭제되었습니다.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "확인", style: .default))
                self.viewAction.send(ViewAction.present(alert))
            }).store(in: &subscriptions)
    }
    
    func bindReviewCellModel(_ model: MovieDetailReviewCellModel) {
        model.deleteReview
            .map { model.review }
            .compactMap { [weak self] review in
                guard let self else { return nil }
                let vc = UIAlertController(title: "리뷰를 삭제하시겠습니까?", message: "비밀번호를 입력해주세요", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default, handler: { _ in
                    guard let password = vc.textFields?.first?.text else { return }
                    if password.sha256() == review.password {
                        self.deleteReview.send(review)
                    } else {
                        let alert = UIAlertController(title: "", message: "올바르지 않은 비밀번호입니다.", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "확인", style: .default))
                        self.viewAction.send(ViewAction.present(alert))
                    }
                })
                let cancel = UIAlertAction(title: "취소", style: .default)
                vc.addAction(cancel)
                vc.addAction(ok)
                vc.addTextField()
                return ViewAction.present(vc)
            }.subscribe(viewAction)
            .store(in: &subscriptions)
    }
    
    enum ViewAction {
        case dismiss
        case share(String)
        case push(_ vc: UIViewController)
        case present(_ vc: UIViewController)
    }
}
