//
//  SecondViewController.swift
//  BoxOffice
//
//  Created by 박도원 on 2023/01/04.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    static var boxofficeData: DailyBoxOfficeList?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setUiLayout()
        addViews()
    }
    
    func getFilmDetailData(completion: @escaping (Result<FilmDetails, Error>) -> Void) {
        if let movieCode = SecondViewController.boxofficeData?.movieCd {
            let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=635cb0b1404820f91c8a45fcdf831615&movieCd=\(movieCode)"
            NetworkManager().getData(url: url, completion: completion)
        }
    }
    
    func setUiLayout() {
        self.getFilmDetailData { result in
            switch result {
            case .success(let success):
                DispatchQueue.main.sync {
                    self.configSecondView(data: success.movieInfoResult.movieInfo)
                }
            case .failure(let failure):
                print(failure.localizedDescription)
            }
        }
    }
    
    func configSecondView(data: MovieInfo) {
        if let boxofficeData = SecondViewController.boxofficeData, let rankInten = Int(boxofficeData.rankInten) {
            let releaseYear = boxofficeData.openDt.split(separator: "-")[0]
            self.navigationItem.title = boxofficeData.movieNm
            rankLabel.text = "순위 \(boxofficeData.rank)위"
            releaseDateLabel.text = "개봉 \(boxofficeData.openDt)"
            spectatorsLabel.text = "관객 \(boxofficeData.audiAcc)명"
            productionYearLabel.text = "제작연도 \(data.prdtYear)"
            releaseYearLabel.text = "개봉연도 \(releaseYear)"
            screeningTimeLabel.text = "상영시간 \(data.showTm)분"
            genreLabel.text = "장르 \(data.genres[0].genreNm)"
            directorNameLabel.text = "감독 \(data.directors[0].peopleNm)"
            if data.actors.isEmpty {
                actorNameLabel.text = "배우 없음"
            } else {
                actorNameLabel.text = "배우 \(data.actors[0].peopleNm), \(data.actors[1].peopleNm ) 등"
            }
            viewingGradeLabel.text = "관람등급 \(data.audits[0].watchGradeNm)"
            
            if boxofficeData.rankOldAndNew == "NEW" {
                newRankButton.alpha = 1
                newRankButton.setTitle(boxofficeData.rankOldAndNew, for: .normal)
            }
            
            if rankInten == 0 {
                rankFluctuationsButton.setTitle("-", for: .normal)
                rankFluctuationsButton.setTitleColor(.gray, for: .normal)
            } else if rankInten > 0 {
                rankFluctuationsButton.setTitle("\(rankInten)", for: .normal)
                rankFluctuationsButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
                rankFluctuationsButton.tintColor = .red
                rankFluctuationsButton.setTitleColor(.red, for: .normal)
            } else {
                rankFluctuationsButton.setTitle("\(abs(rankInten))", for: .normal)
                rankFluctuationsButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
                rankFluctuationsButton.tintColor = .blue
                rankFluctuationsButton.setTitleColor(.blue, for: .normal)
            }
        }
    }
    
    func configImage(data: Search) {
        ImageManager.loadImage(from: data.poster) { image in
            self.posterImageView.image = image
        }
    }
    
    func addViews() {
        let views = [posterImageView, rankLabel, rankFluctuationsButton, releaseDateLabel, spectatorsLabel, productionYearLabel, releaseYearLabel, screeningTimeLabel, genreLabel, directorNameLabel, actorNameLabel, viewingGradeLabel, createReviewButton, newRankButton]
        views.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        setConstraints()
    }

    func setConstraints() {
        let labelConstant = view.frame.width / 3 + 30
        NSLayoutConstraint.activate([

            posterImageView.widthAnchor.constraint(equalToConstant: view.frame.width / 3),
            posterImageView.heightAnchor.constraint(equalToConstant: 220),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            posterImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            
            rankFluctuationsButton.widthAnchor.constraint(equalToConstant: 35),
            rankFluctuationsButton.heightAnchor.constraint(equalToConstant: 20),
            rankFluctuationsButton.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 10),
            rankFluctuationsButton.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -20),
            
            newRankButton.widthAnchor.constraint(equalToConstant: 35),
            newRankButton.heightAnchor.constraint(equalToConstant: 20),
            newRankButton.topAnchor.constraint(equalTo: rankFluctuationsButton.bottomAnchor, constant: 10),
            newRankButton.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -20),
            
            rankLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: labelConstant),
            releaseDateLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: labelConstant),
            spectatorsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: labelConstant),
            productionYearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: labelConstant),
            releaseYearLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: labelConstant),
            screeningTimeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: labelConstant),
            genreLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: labelConstant),
            directorNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: labelConstant),
            actorNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: labelConstant),
            viewingGradeLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: labelConstant),
            
//            filmNameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            rankLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            releaseDateLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor),
            spectatorsLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor),
            productionYearLabel.topAnchor.constraint(equalTo: spectatorsLabel.bottomAnchor),
            releaseYearLabel.topAnchor.constraint(equalTo: productionYearLabel.bottomAnchor),
            screeningTimeLabel.topAnchor.constraint(equalTo: releaseYearLabel.bottomAnchor),
            genreLabel.topAnchor.constraint(equalTo: screeningTimeLabel.bottomAnchor),
            directorNameLabel.topAnchor.constraint(equalTo: genreLabel.bottomAnchor),
            actorNameLabel.topAnchor.constraint(equalTo: directorNameLabel.bottomAnchor),
            viewingGradeLabel.topAnchor.constraint(equalTo: actorNameLabel.bottomAnchor),
            createReviewButton.topAnchor.constraint(equalTo: viewingGradeLabel.bottomAnchor, constant: 60),
            createReviewButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            createReviewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            createReviewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
        ])
    }

    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .blue
        
        return imageView
    }()

    
    let rankFluctuationsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5

        return button
    }()
    
    let newRankButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.setTitleColor(.red, for: .normal)
        button.alpha = 0
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        return button
    }()
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.text = "순위"
        label.textColor = .gray
        
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.text = "개봉"
        label.textColor = .gray
        
        return label
    }()
    
    let spectatorsLabel: UILabel = {
        let label = UILabel()
        label.text = "관객"
        label.textColor = .gray
        
        return label
    }()
    
    let productionYearLabel: UILabel = {
        let label = UILabel()
        label.text = "제작연도"
        label.textColor = .gray
        
        return label
    }()
    
    let releaseYearLabel: UILabel = {
        let label = UILabel()
        label.text = "개봉연도"
        label.textColor = .gray
        
        return label
    }()
    
    let screeningTimeLabel: UILabel = {
        let label = UILabel()
        label.text = "상영시간"
        label.textColor = .gray
        
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.text = "장르"
        label.textColor = .gray
        
        return label
    }()
    
    let directorNameLabel: UILabel = {
        let label = UILabel()
        label.text = "감독"
        label.textColor = .gray
        
        return label
    }()
    
    let actorNameLabel: UILabel = {
        let label = UILabel()
        label.text = "배우"
        label.textColor = .gray
        
        return label
    }()
    
    let viewingGradeLabel: UILabel = {
        let label = UILabel()
        label.text = "관랑등급"
        label.textColor = .gray
        
        return label
    }()
    
    let createReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("리뷰 작성", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .lightGray
        button.addTarget(self, action: #selector(createReview), for: .touchUpInside)
        
        return button
    }()
    
    @objc func createReview(sender: UIButton!) {
        print("버튼 클릭")
    }
    
    @objc func tabDismissButton(sender: UINavigationItem) {
        self.present(MainViewController(), animated: true)
    }
}
