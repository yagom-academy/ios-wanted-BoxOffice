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
    
}

protocol CreateReviewViewModel {
    
    var input: CreateReviewViewModelInput { get }
    var output: CreateReviewViewModelOutput { get }
    
    var cancellables: Set<AnyCancellable> { get }
}

final class DefaultCreateReviewViewModel: CreateReviewViewModel {
    
    private let firestoreManager: FirebaseManager
    private(set) var cancellables: Set<AnyCancellable> = .init()
    private var _isCurrentValid = CurrentValueSubject<Bool, Never>(false)
    private var _currentRating = CurrentValueSubject<Int, Never>(0)
    
    private var _imageData: String = ""
    private var _name: String = ""
    private var _password: String = ""
    private var _review: String = ""
    private var _rating: Int = 0 {
        didSet {
            _currentRating.send(_rating)
        }
    }
    private var _isValid: Bool = false {
        didSet {
            _isCurrentValid.send(_isValid)
        }
    }
    
    init(firestoreManager: FirebaseManager = .init()) {
        self.firestoreManager = firestoreManager
    }
    
}

extension DefaultCreateReviewViewModel: CreateReviewViewModelInput {
    
    var input: CreateReviewViewModelInput { self }
    
    func nameText(_ text: String) {
        _name = text
        _isValid = isValidUserInfo(_password)
    }
    
    func passwordText(_ text: String) {
        _isValid = isValidUserInfo(text)
    }
    
    func reviewText(_ text: String) {
        _review = text
    }
    
    func imageData(_ encodedString: String) {
        guard Data(base64Encoded: encodedString) != nil else {
            return
        }
        _imageData = encodedString
    }
    
    func didTapRatingView(_ rating: Int) {
        _rating = rating
    }
    
    func didTapCreateButton() {
        print(#function)
    }
}

extension DefaultCreateReviewViewModel: CreateReviewViewModelOutput {
    
    var output: CreateReviewViewModelOutput { self }
    
    var isValid: AnyPublisher<Bool, Never> { return _isCurrentValid.eraseToAnyPublisher() }
    
    
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
