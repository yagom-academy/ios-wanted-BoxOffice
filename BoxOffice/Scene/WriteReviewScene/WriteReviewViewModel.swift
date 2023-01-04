//
//  WriteReviewViewModel.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/04.
//

protocol WriteReviewViewModelInput {
    func save(_ review: Review)
}

protocol WriteReviewViewModelOutput {
    var error: Observable<String?> { get set }
}

protocol WriteReviewViewModelType: WriteReviewViewModelInput, WriteReviewViewModelOutput { }

final class WriteReviewViewModel: WriteReviewViewModelType {
    private let reviewFirebaseUseCase = ReviewFirebaseUseCase()
    
    /// Output
    var error: Observable<String?> = Observable(nil)
    
    /// Input
    func save(_ review: Review) {
        reviewFirebaseUseCase.save(review) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
}
