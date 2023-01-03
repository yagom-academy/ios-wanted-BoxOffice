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
    var showAlert: ((UIAlertController) -> Void)?

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
                self?.showAlert?(wrongPasswordAlert)
            }
        })

        actionSheet.addAction(UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            self?.showAlert?(passwordTextFieldAlert)
        })
        actionSheet.addAction(UIAlertAction(title: "취소", style: .cancel))

        showAlert?(actionSheet)
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
