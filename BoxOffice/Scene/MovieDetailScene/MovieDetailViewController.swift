//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/04.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let movieMainInfoView = MovieMainInfoView()
    private let movieSubInfoView = MovieSubInfoView()
    private let movieReviewView = MovieReviewView()
    private let reviewViewModel = MovieReviewViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    let testMovie = MovieDetail(
        currentRank: "1",
        title: "오펀: 천사의 탄생",
        openDate: "20221012",
        totalAudience: "50243",
        rankChange: "-3",
        isNewEntry: true,
        productionYear: "2022",
        openYear: "2022",
        showTime: "146",
        genreName: "공포(호러)",
        directorName: "윌리엄 브렌트 벨",
        actors: "이사벨 퍼만, 줄리아 스타일즈, 로지프 서덜랜드",
        ageLimit: "15세 이상 관람가"
    )
    
    //TODO: 이전 페이지에서 데이터 받아오기
    
    private func setupView() {
        addSubView()
        setupConstraint()
        
    }
    
    private func addSubView() {
        entireStackView.addArrangedSubview(movieMainInfoView)
        entireStackView.addArrangedSubview(movieSubInfoView)
        entireStackView.addArrangedSubview(movieReviewView)
        
        view.addSubview(entireStackView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            entireStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                 constant: 8),
            entireStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                    constant: -8),
            entireStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                     constant: 16),
            entireStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                      constant: -16)
        ])
    }
}
