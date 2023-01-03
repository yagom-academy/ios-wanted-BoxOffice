//
//  movieDetailViewController.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/03.
//

import Foundation
import UIKit

class movieDetailViewController: UIViewController {
    private lazy var posterImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "ironman.jpg"))
        view.backgroundColor = .purple
        return view
    }()
    
    private lazy var titledatetimeageStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .leading
        stackview.distribution = .fill
        return stackview
    }()
    
    private lazy var updownRankingStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .bottom
        stackview.distribution = .equalSpacing
        stackview.spacing = 5
        return stackview
    }()
    
    private lazy var updownImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "arrowtriangle.up.fill"))
        view.backgroundColor = .clear
        view.tintColor = .red
        return view
    }()
    
    private lazy var updownNumberLabel: UILabel = {
        let label = UILabel()
//        label.font = .preferredFont(forTextStyle: .title3)
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.text = "3"
        return label
    }()
    
    private lazy var titleupdownStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .top
        stackview.distribution = .fill
        return stackview
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
//        label.font = .preferredFont(forTextStyle: .title3)
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.text = "가디언즈 오브 갤럭시"
        return label
    }()
    
    private lazy var datetimeageStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .leading
        stackview.distribution = .equalSpacing
        stackview.spacing = 6
        return stackview
    }()
    
    private lazy var releaseDatelabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .white
        label.text = "전체 이용가"
        return label
    }()
    
    private lazy var runningTimeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .white
        label.text = "120분"
        return label
    }()
    
    private lazy var ageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption1)
        label.textColor = .white
        label.text = "전체 이용가"
        return label
    }()
    
    private lazy var shareImageView: UIImageView = {
        let view = UIImageView(image: UIImage(systemName: "square.and.arrow.up"))
        view.backgroundColor = UIColor(r: 26, g: 26, b: 26)
        view.tintColor = .white
        return view
    }()
    
    private lazy var lineView: UIView = {
        var lineView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 0.2))
        lineView.layer.borderWidth = 0.5
        lineView.layer.borderColor = UIColor.white.cgColor
        return lineView
    }()
    
    private lazy var rankingattendancestarsStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .equalSpacing
        stackview.spacing = 5
        return stackview
    }()
    
    private lazy var rankingStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fill
        stackview.spacing = 4
        return stackview
    }()
    
    private lazy var rankingLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.text = "1위"
        return label
    }()
    
    private lazy var boxOfficeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textColor = .gray
        label.text = "박스 오피스"
        return label
    }()
    
    private lazy var attendanceStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fill
        stackview.spacing = 4
        return stackview
    }()
    
    private lazy var attendanceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.text = "123,456"
        return label
    }()
    
    private lazy var cumulativeAudienceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textColor = .gray
        label.text = "누적 관객수"
        return label
    }()
    
    private lazy var reviewStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fill
        stackview.spacing = 4
        return stackview
    }()
    
    private lazy var starsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.text = "4.1"
        return label
    }()
    
    private lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textColor = .gray
        label.text = "리뷰"
        return label
    }()
    private lazy var bottomLineView: UIView = {
        var lineView = UIView(frame: CGRect(x: 0, y: 0, width: 320, height: 0.2))
        lineView.layer.borderWidth = 0.5
        lineView.layer.borderColor = UIColor.white.cgColor
        return lineView
    }()
    
    private lazy var genreStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .bottom
        stackview.distribution = .equalSpacing
        stackview.spacing = 6
        return stackview
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.text = "장르"
        return label
    }()
    
    private lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.text = "액션, 어드벤쳐"
        return label
    }()
    
    private lazy var directorStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .bottom
        stackview.distribution = .equalSpacing
        stackview.spacing = 6
        return stackview
    }()
    
    private lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.text = "감독"
        return label
    }()
    
    private lazy var directorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.text = "john pabro"
        return label
    }()
    
    private lazy var actorStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .bottom
        stackview.distribution = .equalSpacing
        stackview.spacing = 6
        return stackview
    }()
    
    private lazy var actorLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.text = "주연"
        return label
    }()
    
    private lazy var actorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.text = "asdasd, asdasdasd, asdasd"
        return label
    }()
    
    private lazy var productionyearStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .bottom
        stackview.distribution = .equalSpacing
        stackview.spacing = 6
        return stackview
    }()
    
    private lazy var productionyearLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.text = "제작연도"
        return label
    }()
    
    private lazy var productionyearsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.text = "2022"
        return label
    }()
    
    private lazy var reviewButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = UIColor(r: 50, g: 50, b: 50)
        button.setTitle("리뷰하기", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        button.layer.borderWidth = 2
        button.layer.borderColor = UIColor.gray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r: 28, g: 28, b: 28)
        setup()
        setupUI()
    }
    
    private func setup() {
        view.addSubviews(posterImageView, titledatetimeageStackView, shareImageView, lineView, rankingattendancestarsStackView, bottomLineView, genreStackView, directorStackView, actorStackView, productionyearStackView, reviewButton)
        
        updownRankingStackView.addArrangedSubviews(updownImageView, updownNumberLabel)
        
        titleupdownStackView.addArrangedSubviews(titleLabel, updownRankingStackView)
        
        datetimeageStackView.addArrangedSubviews(releaseDatelabel, runningTimeLabel, ageLabel)
        
        titledatetimeageStackView.addArrangedSubviews(titleupdownStackView, datetimeageStackView)
        
        rankingStackView.addArrangedSubviews(rankingLabel, boxOfficeLabel)
        
        attendanceStackView.addArrangedSubviews(attendanceLabel, cumulativeAudienceLabel)
        
        reviewStackView.addArrangedSubviews(starsLabel, reviewLabel)
        
        rankingattendancestarsStackView.addArrangedSubviews(rankingStackView, attendanceStackView, reviewStackView)
        
        genreStackView.addArrangedSubviews(genreLabel, genresLabel)
        
        directorStackView.addArrangedSubviews(directorLabel, directorsLabel)
        
        actorStackView.addArrangedSubviews(actorLabel, actorsLabel)
        
        productionyearStackView.addArrangedSubviews(productionyearLabel, productionyearsLabel)
    }
    
    private func setupUI() {
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 116),
            posterImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 64),
            posterImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -64),
            posterImageView.heightAnchor.constraint(equalToConstant: 325)
        ])
        
        NSLayoutConstraint.activate([
            titledatetimeageStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 29),
            titledatetimeageStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            titledatetimeageStackView.heightAnchor.constraint(equalToConstant: 50)
        ])
        
        NSLayoutConstraint.activate([
            shareImageView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 29),
            shareImageView.leadingAnchor.constraint(equalTo: titledatetimeageStackView.trailingAnchor, constant: 100),
            shareImageView.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor),
            shareImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            lineView.topAnchor.constraint(equalTo: titledatetimeageStackView.bottomAnchor, constant: 5),
            lineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            lineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            lineView.heightAnchor.constraint(equalToConstant: 3)
        ])
        
        NSLayoutConstraint.activate([
            rankingattendancestarsStackView.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 16),
            rankingattendancestarsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            rankingattendancestarsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            rankingattendancestarsStackView.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate([
            bottomLineView.topAnchor.constraint(equalTo: rankingattendancestarsStackView.bottomAnchor, constant: 16),
            bottomLineView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            bottomLineView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -5),
            bottomLineView.heightAnchor.constraint(equalToConstant: 3)
        ])
        
        NSLayoutConstraint.activate([
            genreStackView.topAnchor.constraint(equalTo: bottomLineView.bottomAnchor, constant: 10),
            genreStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            genreStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            directorStackView.topAnchor.constraint(equalTo: genreStackView.bottomAnchor, constant: 4),
            directorStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            directorStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            actorStackView.topAnchor.constraint(equalTo: directorStackView.bottomAnchor, constant: 4),
            actorStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            actorStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            productionyearStackView.topAnchor.constraint(equalTo: actorStackView.bottomAnchor, constant: 4),
            productionyearStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            productionyearStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            reviewButton.topAnchor.constraint(equalTo: productionyearStackView.bottomAnchor, constant: 15),
            reviewButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 7),
            reviewButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -7),
            reviewButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
}

