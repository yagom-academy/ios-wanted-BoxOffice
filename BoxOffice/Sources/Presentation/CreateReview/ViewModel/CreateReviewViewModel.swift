//
//  CreateReviewViewModel.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/04.
//

import Foundation
import Combine

protocol CreateReviewViewModelInput {
    
    func imageData(_ encodedString: String)
    func nameText(_ text: String)
    func passwordText(_ text: String)
    func reviewText(_ text: String)
    func didTapRatingView(_ rating: Int)
    func didTapCreateButton()
    
}

protocol CreateReviewViewModelOutput {
    
    var isValid: AnyPublisher<Bool, Never> { get }
    var rating: AnyPublisher<Double, Never> { get }
    var errorMessage: AnyPublisher<String?, Never> { get }
    var isCompleted: AnyPublisher<Bool?, Never> { get }
    
}

protocol CreateReviewViewModel {
    
    var input: CreateReviewViewModelInput { get }
    var output: CreateReviewViewModelOutput { get }
    
    var cancellables: Set<AnyCancellable> { get }
}

final class DefaultCreateReviewViewModel: CreateReviewViewModel {
    
    private let movie: Movie
    private let firestoreManager: FirebaseManager
    private(set) var cancellables: Set<AnyCancellable> = .init()
    
    private var _isCurrentValid = CurrentValueSubject<Bool, Never>(false)
    private var _currentRating = CurrentValueSubject<Double, Never>(0)
    private var _errorMessage = CurrentValueSubject<String?, Never>(nil)
    private var _isCompleted = CurrentValueSubject<Bool?, Never>(nil)
    
    private var _imageData: String = ""
    private var _name: String = ""
    private var _password: String = ""
    private var _review: String = ""
    private var _rating: Double = 0 {
        didSet {
            _currentRating.send(_rating)
        }
    }
    
    init(movie: Movie, firestoreManager: FirebaseManager = .init()) {
        self.movie = movie
        self.firestoreManager = firestoreManager
    }
    
}

extension DefaultCreateReviewViewModel: CreateReviewViewModelInput {
    
    var input: CreateReviewViewModelInput { self }
    
    func nameText(_ text: String) {
        _name = text
        _isCurrentValid.send(isValidUserInfo(_password))
    }
    
    func passwordText(_ text: String) {
        _isCurrentValid.send(isValidUserInfo(text))
    }
    
    func reviewText(_ text: String) {
        _review = text
        print(text.count)
    }
    
    func imageData(_ encodedString: String) {
        guard Data(base64Encoded: encodedString) != nil else {
            return
        }
        _imageData = encodedString
    }
    
    func didTapRatingView(_ rating: Int) {
        let newRating = Double(rating)
        if newRating == (_rating + 0.5) {
            _rating -= 0.5
        } else if newRating == _rating {
            _rating -= 0.5
        } else {
            _rating = newRating
        }
    }
    
    func didTapCreateButton() {
        let newReview = Review(
            movieName: movie.name,
            userImage: _imageData,
            stars: _rating,
            nickname: _name,
            password: _password,
            review: _review,
            date: Date()
        )
        do {
            try firestoreManager.save(review: newReview)
            _isCompleted.send(true)
        } catch {
            debugPrint(error)
            _errorMessage.send("리뷰를 등록하는 도중 알 수 없는 에러가 발생했습니다.")
        }
    }
}

extension DefaultCreateReviewViewModel: CreateReviewViewModelOutput {
    
    var output: CreateReviewViewModelOutput { self }
    
    var isValid: AnyPublisher<Bool, Never> { return _isCurrentValid.eraseToAnyPublisher() }
    var rating: AnyPublisher<Double, Never> { return _currentRating.eraseToAnyPublisher() }
    var errorMessage: AnyPublisher<String?, Never> { return _errorMessage.eraseToAnyPublisher() }
    var isCompleted: AnyPublisher<Bool?, Never> { return _isCompleted.eraseToAnyPublisher() }
    
}

private extension DefaultCreateReviewViewModel {
    
    func isValidUserInfo(_ password: String) -> Bool {
        guard _name.isEmpty == false, _name.count >= 3 else {
            return false
        }
        guard password.count >= 6,
              password.count <= 20,
              password.isContainsUppercase == false else {
            return false
        }
        guard password.isContainsNumber,
              password.isContainsLowercase,
              password.isContainsSpecialCharacters else {
            return false
        }
        _password = password
        return true
    }
}
