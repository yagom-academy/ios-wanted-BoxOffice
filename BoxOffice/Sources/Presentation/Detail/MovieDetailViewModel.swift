//
//  MovieDetailViewModel.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/04.
//

import Foundation
import Combine
import FirebaseFirestore
import Firebase

protocol MovieDetailViewModelInput {
    func viewWillAppear()
    func deleteReview()
}

protocol MovieDetailViewModelOutput {
    var movie: Movie { get }
    var movieModel: AnyPublisher<Movie, Never> { get }
}

protocol MovieDetailViewModelInterface {
    var input: MovieDetailViewModelInput { get }
    var output: MovieDetailViewModelOutput { get }
}

final class MovieDetailViewModel: MovieDetailViewModelInterface  {
    let firebaseManager = FirebaseManager()
    var input: MovieDetailViewModelInput { self }
    var output: MovieDetailViewModelOutput { self }
    var _movie: Movie
    var reviews: [Review]?
    
    init(movie: Movie) {
        self._movie = movie
    }
    
    private var cancelable = Set<AnyCancellable>()
}

extension MovieDetailViewModel: MovieDetailViewModelInput, MovieDetailViewModelOutput {
    
    var movie: Movie { return _movie }
    
    var movieModel: AnyPublisher<Movie, Never> { return Just(_movie).eraseToAnyPublisher() }
    
    func viewWillAppear() {
        firebaseManager.fetchAll { [weak self] in
            if let self = self {
                self.reviews = $0.filter {
                    $0.movieName == self.movie.name
                }
            }
        }
    }
    
    func deleteReview() {
        
    }
}
