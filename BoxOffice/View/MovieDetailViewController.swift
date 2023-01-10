//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by 이은찬 on 2023/01/06.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        
        return scrollView
    }()
    
    private let movieInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .fill
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .fill
        
        return stackView
    }()
    
    private let nameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.alignment = .leading
        stackView.axis = .horizontal
        stackView.distribution = .equalCentering
        
        return stackView
    }()
    
    private let poster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 0.2
        
        return imageView
    }()
    
    private let movieRank: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        
        return label
    }()
    
    private let movieName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .largeTitle)
        label.numberOfLines = 2
        
        return label
    }()
    
    private let movieOpenDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let movieShowCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let movieUpdatedRank: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        label.clipsToBounds = true
        label.layer.cornerRadius = 9
        label.textAlignment = .center
        label.setContentHuggingPriority(UILayoutPriority(1000), for: .horizontal)
        
        return label
    }()
    
    private let movieOldOrNew: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .green
        
        return label
    }()
    
    private let makeYear: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let openYear: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let runTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let genre: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let directors: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let movieActors: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        label.numberOfLines = 0
        
        return label
    }()
    
    private let showGrade: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDefault()
        setupSubviews()
        setupLayout()
        setupNavigation()
    }
    
    private func setupDefault() {
        view.backgroundColor = .white
    }
    
    private func setupSubviews() {
        view.addSubview(scrollView)
        
        scrollView.addSubview(movieInfoStackView)
        scrollView.addSubview(rankStackView)
        scrollView.addSubview(poster)
    
        rankStackView.addArrangedSubview(movieRank)
        rankStackView.addArrangedSubview(movieUpdatedRank)
        
        nameStackView.addArrangedSubview(movieName)
        nameStackView.addArrangedSubview(movieOldOrNew)
        
        
        movieInfoStackView.addArrangedSubview(nameStackView)
        movieInfoStackView.addArrangedSubview(movieOpenDate)
        movieInfoStackView.addArrangedSubview(movieShowCount)
        movieInfoStackView.addArrangedSubview(makeYear)
        movieInfoStackView.addArrangedSubview(openYear)
        movieInfoStackView.addArrangedSubview(runTime)
        movieInfoStackView.addArrangedSubview(genre)
        movieInfoStackView.addArrangedSubview(directors)
        movieInfoStackView.addArrangedSubview(movieActors)
        movieInfoStackView.addArrangedSubview(showGrade)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            
            rankStackView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            rankStackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 10),
            rankStackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -10),
            
            poster.topAnchor.constraint(equalTo: rankStackView.bottomAnchor, constant: 8),
            poster.heightAnchor.constraint(equalTo: scrollView.heightAnchor, multiplier: 0.5),
            poster.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.75),
            poster.centerXAnchor.constraint(equalTo: scrollView.frameLayoutGuide.centerXAnchor),
            
            movieInfoStackView.topAnchor.constraint(equalTo: poster.bottomAnchor, constant: 8),
            movieInfoStackView.leadingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.leadingAnchor, constant: 10),
            movieInfoStackView.trailingAnchor.constraint(equalTo: scrollView.frameLayoutGuide.trailingAnchor, constant: -10),
            movieInfoStackView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor)
        ])
    }
    
    private func setupNavigation() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "리뷰 작성",
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
    }
    
    func configure(_ movie: MovieEssentialInfo) {
        DispatchQueue.global().async {
            guard let url = URL(string: movie.posterUrl),
                  let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.poster.image = UIImage(data: data)
            }
        }
        movieRank.text = "\(movie.rank)위"
        movieName.text = movie.movieNm
        movieOpenDate.text = "개봉일 : \(movie.openDt)"
        movieShowCount.text = "상영시간 : \(movie.audiAcc)"
        changeBackgourndOfUpdateRank(movie.rankInten)
        if movie.rankOldAndNew == "NEW" {
            movieOldOrNew.text = movie.rankOldAndNew
        }
        makeYear.text = "제작년도 : \(movie.prdtYear)"
        openYear.text = "개봉년도 : \(movie.openYear)"
        runTime.text = "상영시간 : \(movie.showTm)분"
        genre.text = "장르 : \(movie.genres)"
        var actors: String = ""
        movie.actors.forEach { `actor` in
            actors += "\(`actor`.peopleNm)  "
        }
        directors.text = "감독 : \(movie.directors.first!.peopleNm)"
        movieActors.text = "배우 : \(actors)"
        showGrade.text = "관람등급 : \(movie.watchGradeNm)"
    }
    
    private func changeBackgourndOfUpdateRank(_ number: String?) {
        guard let rankInten = Int(number ?? "") else { return }
        if rankInten > 0 {
            movieUpdatedRank.backgroundColor = .green
            movieUpdatedRank.text = " (+\(rankInten))"
        } else if rankInten < 0 {
            movieUpdatedRank.backgroundColor = .red
            movieUpdatedRank.text = " (\(rankInten))"
        } else {
            movieUpdatedRank.isHidden = true
        }
    }
    
    @objc func writeReviewButtonDidTapped() {
    }
}
