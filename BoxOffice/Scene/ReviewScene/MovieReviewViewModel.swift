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
    var rating: Observable<String> { get set }
    var error: Observable<String?> { get set }
}

protocol MovieReviewViewModelType: MovieReviewViewModelInput, MovieReviewViewModelOutput { }

final class MovieReviewViewModel: MovieReviewViewModelType {
    private let reviewFirebaseUseCase = ReviewFirebaseUseCase()
    
    /// Output
    var reviews: Observable<[Review]> = Observable([])
    var rating: Observable<String> = Observable("")
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
        
        fetch(at: movieKey)
    }
    
    func fetch(at movieKey: String) {
        reviewFirebaseUseCase.fetch(at: movieKey) { [weak self] result in
            switch result {
            case .success(let reviews):
                self?.reviews.value = reviews
                self?.calculateRating()
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
    }
    
    func delete(_ review: Review, at movieKey: String) {
        reviewFirebaseUseCase.delete(review, at: movieKey) { [weak self] result in
            switch result {
            case .success(_):
                break
            case .failure(let error):
                self?.error.value = error.localizedDescription
            }
        }
        
        fetch(at: movieKey)
    }
    
    func calculateRating() {
        let ratings = reviews.value.map { $0.rating }
        let ratingValues = ratings.compactMap { Double($0) }
        let ratingSum = ratingValues.reduce(0, +)
        
        rating.value = String(format: "%.1f", ratingSum / Double(ratingValues.count))
    }
}

