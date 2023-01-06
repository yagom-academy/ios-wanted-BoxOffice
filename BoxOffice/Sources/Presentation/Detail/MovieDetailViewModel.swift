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
    func didTapShareButton()
}

protocol MovieDetailViewModelOutput {
    var movie: Movie { get }
    var movieModel: AnyPublisher<Movie, Never> { get }
    var reviewModel: AnyPublisher<[Review], Never> { get }
    var shareMovieInfoPublisher: PassthroughSubject<[String], Never> { get }

}

protocol MovieDetailViewModelInterface {
    var input: MovieDetailViewModelInput { get }
    var output: MovieDetailViewModelOutput { get }
}

final class MovieDetailViewModel: MovieDetailViewModelInterface  {
    var input: MovieDetailViewModelInput { self }
    var output: MovieDetailViewModelOutput { self }
    var _movie: Movie
    @Published var _reviews: [Review]?
    private var _reviewModel = CurrentValueSubject<[Review], Never>([])
    var shareMovieInfoPublisher = PassthroughSubject<[String], Never>()
    
    init(movie: Movie) {
        self._movie = movie
    }
    
    private var cancelable = Set<AnyCancellable>()
}

extension MovieDetailViewModel: MovieDetailViewModelInput, MovieDetailViewModelOutput {
    var movie: Movie { return _movie }
    var movieModel: AnyPublisher<Movie, Never> { return Just(_movie).eraseToAnyPublisher() }
    var reviewModel: AnyPublisher<[Review], Never> { return _reviewModel.eraseToAnyPublisher() }
    var review: [Review]? {
        return _reviews
    }
    
    
    func viewWillAppear() {
        FirebaseManager.shared.fetchAll { [weak self] reviews in
            if let self = self {
                var movieReview = reviews.filter {
                    $0.movieName == self.movie.name
                }
                self._reviews = movieReview
                
                self._reviewModel.send(movieReview)
            }
        }
    }
    
    func didTapShareButton() {
        guard let boxOfficeInfo = movie.boxOfficeInfo,
              let detailInfo = movie.detailInfo else { return }
        
        shareMovieInfoPublisher.send([
        """
        🍿 BoxOffice Information 🍿
        영화명: \(movie.name)
        순위증감분: \(String(describing: boxOfficeInfo.rankInten))
        개봉일: \(String(describing: movie.openDate))
        제작연도: \(String(describing: movie.detailInfo?.productionYear))
        상영시간: \(String(describing: detailInfo.showTime))
        관람등급: \(String(describing: detailInfo.audit))
        박스오피스 순위: \(String(describing: boxOfficeInfo.rank))
        누적 관객수: \(String(describing: boxOfficeInfo.audienceAccumulation))명
        랭킹 신규 진입: \(String(describing: boxOfficeInfo.rankOldAndNew.rawValue))
        장르: \(String(describing: detailInfo.genres.first ?? ""))
        감독: \(detailInfo.directors.first ?? "")
        주연: \(detailInfo.actors.first ?? "")
        """
        ])
    }
    
    func deleteReview() {
        
    }
}

