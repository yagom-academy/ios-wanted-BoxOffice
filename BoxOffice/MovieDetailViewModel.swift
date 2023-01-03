//
//  MovieDetailViewModel.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

final class MovieDetailViewModel {

    // MARK: - Outputs
    var tabBarMode: TabBarMode = .movieInfo
    var movieDetail = dummyMovieDetail
    var movieReviews = [MovieReview]()
    var averageRating: Double {
        let average: Double = movieReviews.reduce(into: 0) { previous, review in
            previous += review.rating
        } / Double(movieReviews.count)
        return average
    }

    // MARK: - UseCases
    private let fetchMovieDetailUseCase = FetchMovieDetailUseCase()
    private let fetchMovieReviewUseCase = FetchMovieReviewsUseCase()
    private let deleteMovieReviewUseCase = DeleteMovieReviewUseCase()

    // MARK: - Actions
    var applyDataSource: (() -> Void)?
    var scrollToUpper: (() -> Void)?
    var showDeleteActionSheet: ((UIAlertController) -> Void)?

    // MARK: - Private properties
    private let movieCode: String

    init(movieCode: String) {
        self.movieCode = movieCode
    }
}

// MARK: - Inputs
extension MovieDetailViewModel {
    func viewDidLoad() {
        fetchMovieDetail(movieCode: movieCode)
        fetchMovieReview(movieCode: movieCode)
    }

    func tabBarModeChanged(mode: TabBarMode) {
        tabBarMode = mode
        applyDataSource?()
        scrollToUpper?()
    }

    func deleteReviewButtonTapped(review: MovieReview) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            self?.deleteMovieReview(review: review)
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))

        showDeleteActionSheet?(alert)
    }

    func shareButtonTapped() {

    }
}

// MARK: - Private functions
extension MovieDetailViewModel {
    private func fetchMovieDetail(movieCode: String) {
        fetchMovieDetailUseCase.execute(movieCode: movieCode) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                self?.movieDetail = movieDetail
                self?.applyDataSource?()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func fetchMovieReview(movieCode: String) {
        fetchMovieReviewUseCase.execute(movieCode: movieCode) { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.movieReviews = reviews
                self?.applyDataSource?()
            case .failure(let error):
                print(error)
            }
        }
    }

    private func deleteMovieReview(review: MovieReview) {
        deleteMovieReviewUseCase.execute(review: review) { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                print(error)
            }
        }
    }
}

// MARK: - TabBarMode
extension MovieDetailViewModel {
    enum TabBarMode {
        case movieInfo
        case review
    }
}
