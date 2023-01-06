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
    
}

protocol CreateReviewViewModel {
    
    var input: CreateReviewViewModelInput { get }
    var output: CreateReviewViewModelOutput { get }
    
    var cancellables: Set<AnyCancellable> { get }
}

final class DefaultCreateReviewViewModel: CreateReviewViewModel {
    
    private let firestoreManager: FirebaseManager
    private(set) var cancellables: Set<AnyCancellable> = .init()
    
    init(firestoreManager: FirebaseManager = .init()) {
        self.firestoreManager = firestoreManager
    }
    
}

extension DefaultCreateReviewViewModel: CreateReviewViewModelInput {
    
    var input: CreateReviewViewModelInput { self }
    
    func nameText(_ text: String) {
        print(text)
    }
    
    func passwordText(_ text: String) {
        print(text)
    }
    
    func reviewText(_ text: String) {
        print(text)
    }
    
    func imageData(_ encodedString: String) {
        if let data = Data(base64Encoded: encodedString) {
            print(data)
        }
    }
    
    func didTapRatingView(_ rating: Int) {
        print(rating)
    }
    
    func didTapCreateButton() {
        print(#function)
    }
}

extension DefaultCreateReviewViewModel: CreateReviewViewModelOutput {
    
    var output: CreateReviewViewModelOutput { self }
    
}
