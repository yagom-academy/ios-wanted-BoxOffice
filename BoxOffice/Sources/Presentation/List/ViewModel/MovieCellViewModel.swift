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
    
    var currentMovie: Movie { get }
    
    var movie: AnyPublisher<Movie, Never> { get }
    
}

protocol MovieCellViewModel: MovieCellViewModelInput, MovieCellViewModelOutput {
    
    var input: MovieCellViewModelInput { get }
    var output: MovieCellViewModelOutput { get }
    
    var cancellables: Set<AnyCancellable> { get }
}

final class DefaultMovieCellViewModel: MovieCellViewModel {
    
    
    private let repository: BoxOfficeRepository
    private(set) var cancellables: Set<AnyCancellable> = .init()
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
    
    var currentMovie: Movie { return _currentMovie }
    var movie: AnyPublisher<Movie, Never> { return Just(_currentMovie).eraseToAnyPublisher() }
    
}

private extension DefaultMovieCellViewModel {
    
    func bind() {
        repository.movieInfo(code: _currentMovie.code)
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    debugPrint(error)
                }
            }, receiveValue: { [weak self] info in
                guard let self else {
                    return
                }
                self._currentMovie.detailInfo = info
                self._movie.send(self._currentMovie)
            }).store(in: &cancellables)
        
        _movie
            .filter { $0.detailInfo?.poster == nil }
            .compactMap { $0.detailInfo?.movieNameEnglish }
            .flatMap { [weak self] movieName -> AnyPublisher<String, Error> in
                guard let self else {
                    return Empty().eraseToAnyPublisher()
                }
                return self.repository.moviePoster(name: movieName)
            }.sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    debugPrint(error)
                }
            }, receiveValue: { posterURL in
                self._currentMovie.detailInfo?.poster = posterURL
            }).store(in: &cancellables)
    }
    
}
    
