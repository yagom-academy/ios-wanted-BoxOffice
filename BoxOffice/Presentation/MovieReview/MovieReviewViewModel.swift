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
    
    func viewDidLoad() {
        
    }
    
    func photoAddingButtonTapped() {
        presentImagePicker?()
    }
}
