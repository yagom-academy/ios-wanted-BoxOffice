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
    var showAlert: ((UIAlertController) -> Void)?
    var popViewController: (() -> Void)?
    
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
            guard let selectedPhoto = selectedPhoto else {
                return
            }
            
            uploadReviewUseCase.execute(image: selectedPhoto, review: movieReview) { [weak self] result in
                switch result {
                case .success:
                    self?.popViewController?()
                case .failure(let error):
                    let alert = UIAlertController(title: "리뷰가 정상적으로 등록되지 않았어요", message: "네트워크 상태를 확인해주세요.", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "확인", style: .cancel))
                    
                    self?.showAlert?(alert)
                    print(error)
                }
            }
        } else {
            let alert = UIAlertController(title: "빠진 정보가 있는 것 같아요.", message: "별점, 관람평, 닉네임, 패스워드를 모두 채워주셨나요?", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            showAlert?(alert)
        }
    }

    func isValid(password: String) -> Bool {
      if password.count < 6 || password.count > 20 {
        return false
      }

      let lowercaseCharacterSet = CharacterSet.lowercaseLetters
      if password.rangeOfCharacter(from: lowercaseCharacterSet) == nil {
        return false
      }

      let decimalDigitCharacterSet = CharacterSet.decimalDigits
      if password.rangeOfCharacter(from: decimalDigitCharacterSet) == nil {
        return false
      }

      let specialSymbolCharacterSet = CharacterSet(charactersIn: "!@#$")
      if password.rangeOfCharacter(from: specialSymbolCharacterSet) == nil {
        return false
      }

      return true
    }
    
    private func isValid(movieReview: MovieReview) -> Bool {
        if movieReview.rating != 0,
           movieReview.user.nickname != "",
           isValid(password: movieReview.password),
           movieReview.description != "" {
            return true
        }
        
        return false
    }
}
