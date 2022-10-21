//
//  CreateReviewViewModel.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/21.
//

import Foundation
import UIKit
import Combine

class CreateReviewViewModel {
    // MARK: Subjects
    let viewAction = PassthroughSubject<ViewAction, Never>()
    
    // MARK: Output
    @Published var movie: Movie
    @Published var posterImage: UIImage?
    @Published var rating: Int = 0
    @Published var nickname: String?
    @Published var password: String?
    @Published var content: String?
    @Published var reviewImage: UIImage?
    @Published var isValid: Bool = false
    
    @Published var ratingViewModel = RatingViewModel()
    
    // MARK: Properties
    let repository = Repository()
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init(movie: Movie) {
        self.movie = movie
        bind()
    }
    
    
    // MARK: Binding
    func bind() {
        $movie
            .filter { _ in self.posterImage == nil }
            .compactMap { $0.detailInfo?.poster }
            .prefix(1)
            .flatMap { [weak self] url -> AnyPublisher<UIImage, Error> in
                guard let self else { return Empty().eraseToAnyPublisher() }
                return self.repository.loadImage(url)
            }.sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    debugPrint("😡Error Occured While Loading Movie Poster Image: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] image in
                guard let self else { return }
                self.posterImage = image
            }).store(in: &subscriptions)
        
        ratingViewModel.$rating
            .sink(receiveValue: { [weak self] rating in
                guard let self else { return }
                self.rating = rating
            }).store(in: &subscriptions)
        
        $rating
            .combineLatest($nickname, $password, $content)
            .map { (rating, nickname, password, content) in
                guard
                    rating > 0,
                    nickname != nil && nickname!.count > 0,
                    password != nil && password!.validatePassword(),
                    content != nil && content!.count > 0
                else { return false }
                return true
            }.assign(to: \.isValid, on: self)
            .store(in: &subscriptions)
    }
    
    enum ViewAction {
        case dismiss
        case showPHPicker
    }
}
