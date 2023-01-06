//
//  MovieDetailViewModel.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/05.
//

protocol MovieDetailViewModelInput {
    func fetch(at movieKey: String)
}

protocol MovieDetailViewModelOutput {
    var reviews: Observable<[Review]> { get set }
    var error: Observable<String?> { get set }
}

protocol MovieDetailViewModelType: MovieDetailViewModelInput, MovieDetailViewModelOutput { }

final class MovieDetailViewModel: MovieDetailViewModelType {
    private let reviewFirebaseUseCase = ReviewFirebaseUseCase()
    
    /// Output
    var reviews: Observable<[Review]> = Observable([])
    var error: Observable<String?> = Observable(nil)
    
    /// Input
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
    
    //TODO: MovieDetail 생성하기??
}
