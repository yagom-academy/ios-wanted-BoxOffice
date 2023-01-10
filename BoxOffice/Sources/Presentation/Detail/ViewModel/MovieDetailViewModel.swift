//
//  MovieDetailViewModel.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/04.
//

import UIKit
import Foundation
import Combine
import FirebaseFirestore
import Firebase

protocol MovieDetailViewModelInput {
    func viewWillAppear()
    func deleteReview(_ index: Int) -> UIAlertController
    func didTapShareButton()
    func checkPassword(_ inputPassword: String, index: Int)
}

protocol MovieDetailViewModelOutput {
    var movie: Movie { get }
    var movieModel: AnyPublisher<Movie, Never> { get }
    var reviewModel: AnyPublisher<[Review], Never> { get }
    var shareMovieInfoPublisher: PassthroughSubject<[String], Never> { get }
    var errorMessage: AnyPublisher<String?, Never> { get }
}

protocol MovieDetailViewModelInterface {
    var input: MovieDetailViewModelInput { get }
    var output: MovieDetailViewModelOutput { get }
}

final class MovieDetailViewModel: MovieDetailViewModelInterface  {
    var input: MovieDetailViewModelInput { self }
    var output: MovieDetailViewModelOutput { self }
    var _movie: Movie
    @Published var _reviews: [Review] = []
    private var _reviewModel = CurrentValueSubject<[Review], Never>([])
    var shareMovieInfoPublisher = PassthroughSubject<[String], Never>()
    var _errorMessage = CurrentValueSubject<String?, Never>(nil)
    init(movie: Movie) {
        self._movie = movie
    }
    
    private var cancelable = Set<AnyCancellable>()
}

extension MovieDetailViewModel: MovieDetailViewModelInput, MovieDetailViewModelOutput {
    var movie: Movie { return _movie }
    var movieModel: AnyPublisher<Movie, Never> { return Just(_movie).eraseToAnyPublisher() }
    var reviewModel: AnyPublisher<[Review], Never> { return _reviewModel.eraseToAnyPublisher() }
    var review: [Review] {
        return _reviews
    }
    var errorMessage: AnyPublisher<String?, Never> { return _errorMessage.eraseToAnyPublisher() }
    
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
        개봉일: \(movie.openDate.toString(.yyyyMMddDot))
        제작연도: \(detailInfo.productionYear)
        상영시간: \(String(describing: detailInfo.showTime))
        관람등급: \(String(describing: detailInfo.audit))
        박스오피스 순위: \(String(describing: boxOfficeInfo.rank))
        누적 관객수: \(boxOfficeInfo.audienceAccumulation.numberFormatter())명
        랭킹 신규 진입: \(String(describing: boxOfficeInfo.rankOldAndNew.rawValue))
        장르: \(detailInfo.genres.joined(separator: ", "))
        감독: \(detailInfo.directors.joined(separator: ", "))
        주연: \(detailInfo.actors.joined(separator: ", "))
        """
        ])
    }
    
    func deleteReview(_ index: Int) -> UIAlertController {
        let userPassword = review[index - 3].password
        
        let alertVC = UIAlertController(title: nil, message: "암호를 입력해주세요.", preferredStyle: .alert)
        
        alertVC.addTextField()
        let textField = alertVC.textFields?.first
        textField?.textContentType = .password
        textField?.isSecureTextEntry = true
        
        let confirm = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            if let inputPassword = textField?.text {
                guard let self = self else { return }
                if inputPassword == userPassword {
                    FirebaseManager.shared.delete(review: self.review[index - 3])
                    self._reviews.remove(at: index - 3)
                    self._reviewModel.send(self._reviews)
                } else {
                    print("비밀번호 불일치")
                }
            }
        }
        let cancel = UIAlertAction(title: "취소", style: .cancel)
        
        alertVC.addAction(confirm)
        alertVC.addAction(cancel)
        
        return alertVC
    }
    
    func checkPassword(_ inputPassword: String, index: Int) {
        let userPassword = review[index - 3].password
        
        if inputPassword == userPassword {
            FirebaseManager.shared.delete(review: self.review[index - 3])
            self._reviews.remove(at: index - 3)
            self._reviewModel.send(self._reviews)
        } else {
            _errorMessage.send("비밀번호가 일치하지 않습니다.")
        }
    }
}

