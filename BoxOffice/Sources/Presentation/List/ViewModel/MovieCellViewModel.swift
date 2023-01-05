//
//  MovieCellViewModel.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/05.
//

import Foundation
import Combine

protocol MovieCellViewModelInput {}

protocol MovieCellViewModelOutput {
    
    var movie: Movie { get }
    
}

protocol MovieCellViewModel: MovieCellViewModelInput, MovieCellViewModelOutput {
    
    var input: MovieCellViewModelInput { get }
    var output: MovieCellViewModelOutput { get }
    
}

final class DefaultMovieCellViewModel: MovieCellViewModel {
    
    
    private let repository: BoxOfficeRepository
    private var subscriptions = [AnyCancellable]()
    private var _movie = PassthroughSubject<Movie, Never>()
    
    @Published private var _currentMovie: Movie
    
    init(movie: Movie, repository: BoxOfficeRepository = DefaultBoxOfficeRepository()) {
        self._currentMovie = movie
        self.repository = repository
        bind()
    }
    
}

extension DefaultMovieCellViewModel: MovieCellViewModelInput {
    
    var input: MovieCellViewModelInput { self }
    
}

extension DefaultMovieCellViewModel: MovieCellViewModelOutput {
    
    var output: MovieCellViewModelOutput { self }
    
    var movie: Movie { return _currentMovie }
    
}

private extension DefaultMovieCellViewModel {
    
    func bind() {
        $_currentMovie
            .filter { $0.detailInfo == nil }
            .prefix(1)
            .map { $0.code }
            .flatMap { [weak self] movieCode -> AnyPublisher<MovieDetailInfo, Error> in
                guard let self else {
                    return Empty().eraseToAnyPublisher()
                }
                return self.repository.movieInfo(code: movieCode)
            }.sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    debugPrint(error)
                }
            }, receiveValue: { [weak self] info in
                self?._currentMovie.detailInfo = info
            }).store(in: &subscriptions)
        
        $_currentMovie
            .filter { $0.detailInfo?.poster == nil }
            .compactMap { $0.detailInfo?.movieNameEnglish }
            .prefix(1)
            .flatMap { [weak self] movieName -> AnyPublisher<String, Error> in
                guard let self else {
                    return Empty().eraseToAnyPublisher()
                }
                return self.repository.moviePoster(name: movieName)
            }.sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    debugPrint(error)
                }
            }, receiveValue: { [weak self] posterURL in
                guard let self else {
                    return
                }
                self._currentMovie.detailInfo?.poster = posterURL
                self._movie.send(self._currentMovie)
            }).store(in: &subscriptions)
    }
    
}
    
