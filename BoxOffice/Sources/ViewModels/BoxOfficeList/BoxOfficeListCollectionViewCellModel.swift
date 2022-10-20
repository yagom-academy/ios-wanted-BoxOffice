//
//  BoxOfficeListCollectionViewCellModel.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/19.
//

import Foundation
import UIKit
import Combine

class BoxOfficeListCollectionViewCellModel {
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
            .filter { $0.detailInfo == nil }
            .prefix(1)
            .map(\.movieCode)
            .flatMap { [weak self] movieCode -> AnyPublisher<MovieDetailInfo, Error> in
                guard let self else { return Empty().eraseToAnyPublisher() }
                return self.repository.movieDetail(movieCode)
            }
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    debugPrint("😡Error Occured While Loading Movie Detail: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] info in
                guard let self else { return }
                self.movie.detailInfo = info
            }).store(in: &subscriptions)
        
        $movie
            .filter { $0.detailInfo?.poster == nil }
            .compactMap { $0.detailInfo?.movieNameEnglish }
            .prefix(1)
            .flatMap { [weak self] name -> AnyPublisher<String, Error> in
                guard let self else { return Empty().eraseToAnyPublisher() }
                return self.repository.moviePoster(name)
            }.sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    debugPrint("😡Error Occured While Loading Movie Poster URL: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] url in
                guard let self else { return }
                self.movie.detailInfo?.poster = url
            }).store(in: &subscriptions)
        
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
