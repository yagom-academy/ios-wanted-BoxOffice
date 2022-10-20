//
//  MoviePosterViewModel.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/20.
//

import Foundation
import UIKit
import Combine

class MoviePosterViewModel {
    // MARK: Input
    
    // MARK: Output
    @Published var movie: Movie
    @Published var posterImage: UIImage?
    
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
    }
}
