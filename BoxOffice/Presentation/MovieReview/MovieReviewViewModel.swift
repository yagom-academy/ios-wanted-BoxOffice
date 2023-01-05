//
//  MovieReviewViewModel.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/06.
//

import UIKit

final class MovieReviewViewModel {

    // MARK: - Outputs
    private var selectedPhoto: UIImage?
    
    // MARK: - UseCases
    private let uploadReviewUseCase = UploadReviewUseCase()
    
    // MARK: - Actions
    var presentImagePicker: (() -> Void)?
    var retrieveSelectedPhoto: (() -> Void)?
    var presentViewController: ((UIViewController) -> Void)?
    
    func viewDidLoad() {
        
    }
    
    func photoAddingButtonTapped() {
        presentImagePicker?()
    }
    
    func imageSelected(image: UIImage) {
        selectedPhoto = image
    }
    
    func registrationButtonTapped(movieReview: MovieReview) {
        if isValid(movieReview: movieReview) {
            // TODO: upload review
        } else {
            let alert = UIAlertController(title: "빠진 정보가 있는 것 같아요.", message: "별점, 관람평, 닉네임, 패스워드를 모두 채워주셨나요?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            presentViewController?(alert)
        }
    }
    
    private func isValid(movieReview: MovieReview) -> Bool {
        if movieReview.rating != 0,
           movieReview.user.nickname != "",
           movieReview.password != "",
           movieReview.description != "" {
            return true
        }
        
        return false
    }
}
