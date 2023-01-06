//
//  WriteReviewViewModel.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/04.
//

protocol MovieReviewViewModelInput {
    func save(_ review: Review, at movieKey: String)
    func fetch(at movieKey: String)
}

protocol MovieReviewViewModelOutput {
    var reviews: Observable<[Review]> { get set }
    var error: Observable<String?> { get set }
}

protocol MovieReviewViewModelType: MovieReviewViewModelInput, MovieReviewViewModelOutput { }

final class MovieReviewViewModel: MovieReviewViewModelType {
    private let reviewFirebaseUseCase = ReviewFirebaseUseCase()
    
    /// Output
    var reviews: Observable<[Review]> = Observable([])
    var error: Observable<String?> = Observable(nil)
    
    /// Input
    func save(_ review: Review, at movieKey: String) {
        reviewFirebaseUseCase.save(review, at: movieKey) { result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                self.error.value = error.localizedDescription
            }
        }
    }
    
    func fetch(at movieKey: String) {
        reviewFirebaseUseCase.fetch(at: movieKey) { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.reviews.value = reviews
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
    }
}
