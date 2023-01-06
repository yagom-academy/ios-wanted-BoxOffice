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
    var movieOverview = dummyMovieOverview
    var movieReviews = [MovieReview]()
    var averageRating: Double {
        if movieReviews.isEmpty { return 0 }
        let average: Double = movieReviews.reduce(into: 0) { previous, review in
            previous += review.rating
        } / Double(movieReviews.count)
        return average
    }
    var posterImage: UIImage?

    // MARK: - UseCases
    private let fetchMovieDetailUseCase = FetchMovieDetailUseCase()
    private let fetchMovieReviewUseCase = FetchMovieReviewsUseCase()
    private let deleteMovieReviewUseCase = DeleteMovieReviewUseCase()
    private let fetchPosterImageUseCase = FetchPosterImageUseCase()

    // MARK: - Actions
    var applyDataSource: (() -> Void)?
    var scrollToUpper: (() -> Void)?
    var presentViewController: ((UIViewController) -> Void)?
    var startLoadingIndicator: (() -> Void)?
    var stopLoadingIndicator: (() -> Void)?

    // MARK: - Private properties
    private let movieCode: String
    private var fetchMovieDetailTask: Cancellable?
    private var fetchPosterImageTask: Cancellable?

    init(movieOverview: MovieOverview) {
        self.movieCode = movieOverview.movieCode
        self.movieOverview = movieOverview
    }
}

// MARK: - Inputs
extension MovieDetailViewModel {
    func viewDidLoad() {
        fetchMovieDetail(movieCode: movieCode)
        fetchMovieReview(movieCode: movieCode)
    }

    func viewWillAppear() {
        fetchMovieReview(movieCode: movieCode)
    }

    func tabBarModeChanged(mode: TabBarMode) {
        tabBarMode = mode
        applyDataSource?()
        scrollToUpper?()
    }

    func deleteReviewButtonTapped(review: MovieReview) {
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        let passwordTextFieldAlert = UIAlertController(title: "암호를 입력해주세요", message: nil, preferredStyle: .alert)
        passwordTextFieldAlert.addTextField { textField in
            textField.isSecureTextEntry = true
        }
        let wrongPasswordAlert = UIAlertController(title: "비밀번호가 틀렸습니다", message: nil, preferredStyle: .alert)
        wrongPasswordAlert.addAction(UIAlertAction(title: "확인", style: .cancel))

        passwordTextFieldAlert.addAction(UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            guard let password = passwordTextFieldAlert.textFields?.first?.text else { return }
            if review.password == password {
                self?.deleteMovieReview(review: review)
            } else {
                self?.presentViewController?(wrongPasswordAlert)
            }
        })

        actionSheet.addAction(UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            self?.presentViewController?(passwordTextFieldAlert)
        })
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))

        presentViewController?(actionSheet)
    }

    func shareButtonTapped(screenImage: UIImage?) {
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "현재 화면 공유하기", style: .default) { [weak self] _ in
            guard let screenImage = screenImage else { return }
            let activityViewController = UIActivityViewController(
                activityItems: [screenImage],
                applicationActivities: nil)
            self?.presentViewController?(activityViewController)
        })
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        presentViewController?(alert)
    }
}

// MARK: - Private functions
extension MovieDetailViewModel {
    private func fetchMovieDetail(movieCode: String) {
        startLoadingIndicator?()
        fetchMovieDetailTask = fetchMovieDetailUseCase.execute(movieCode: movieCode) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                self?.movieDetail = movieDetail
                self?.fetchPosterImage()
                self?.applyDataSource?()
            case .failure(let error):
                print(error)
            }
            self?.stopLoadingIndicator?()
        }

        fetchMovieDetailTask?.resume()
    }

    private func fetchMovieReview(movieCode: String) {
        startLoadingIndicator?()
        fetchMovieReviewUseCase.execute(movieCode: movieCode) { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.movieReviews = reviews
            case .failure(let error):
                print(error)
            }
            self?.applyDataSource?()
            self?.stopLoadingIndicator?()
        }
    }

    private func deleteMovieReview(review: MovieReview) {
        startLoadingIndicator?()
        deleteMovieReviewUseCase.execute(review: review) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case .success:
                self.fetchMovieReview(movieCode: self.movieOverview.movieCode)
            case .failure(let error):
                print(error)
            }
            self.stopLoadingIndicator?()
        }
    }

    private func fetchPosterImage() {
        fetchPosterImageTask = fetchPosterImageUseCase
            .execute(englishMovieTitle: movieDetail.englishTitle, year: movieOverview.openingDay.toYearString()) { [weak self] result in
            switch result {
            case .success(let image):
                self?.posterImage = image
            case .failure(let error):
                print(error)
            }
            self?.applyDataSource?()
        }

        fetchPosterImageTask?.resume()
    }
}

// MARK: - TabBarMode
extension MovieDetailViewModel {
    enum TabBarMode {
        case movieInfo
        case review
    }
}

fileprivate extension Date {
    func toYearString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy"
        return dateFormatter.string(from: self)
    }
}
