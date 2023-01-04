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
    var presentViewController: ((UIViewController) -> Void)?
    var startLoadingIndicator: (() -> Void)?
    var stopLoadingIndicator: (() -> Void)?

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
        alert.addAction(UIAlertAction(title: "포스터 이미지 공유하기", style: .default) { [weak self] _ in
            guard let urlString = self?.movieDetail.posterImageURL,
                  let url = URL(string: urlString) else { return }
            let activityViewController = UIActivityViewController(
                activityItems: [url],
                applicationActivities: nil)
            self?.presentViewController?(activityViewController)
        })
        alert.addAction(UIAlertAction(title: "현재 화면 저장하기", style: .default) { [weak self] _ in
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
        fetchMovieDetailUseCase.execute(movieCode: movieCode) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                self?.movieDetail = movieDetail
                self?.applyDataSource?()
            case .failure(let error):
                print(error)
            }
            self?.stopLoadingIndicator?()
        }
    }

    private func fetchMovieReview(movieCode: String) {
        startLoadingIndicator?()
        fetchMovieReviewUseCase.execute(movieCode: movieCode) { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.movieReviews = reviews
                self?.applyDataSource?()
            case .failure(let error):
                print(error)
            }
            self?.stopLoadingIndicator?()
        }
    }

    private func deleteMovieReview(review: MovieReview) {
        startLoadingIndicator?()
        deleteMovieReviewUseCase.execute(review: review) { [weak self] result in
            switch result {
            case .success:
                self?.applyDataSource?()
            case .failure(let error):
                print(error)
            }
            self?.stopLoadingIndicator?()
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
