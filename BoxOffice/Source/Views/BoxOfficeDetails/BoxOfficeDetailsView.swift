//
//  BoxOfficeDetailsView.swift
//  BoxOffice
//
//  Created by KangMingyo on 2022/10/19.
//

import UIKit

class BoxOfficeDetailsView: UIView {

    let posterImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
    
    //관람등급
    let auditsImageView: UIImageView = {
         let imageView = UIImageView()
         imageView.translatesAutoresizingMaskIntoConstraints = false
         return imageView
     }()
    
    let movieName: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .bold)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieNameEn: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12)
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 2
        label.textColor = .systemGray
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genres: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let openDate: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let showTime: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let prdtYear: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let lineView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemGray6
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let boxOfficeRank: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let boxOfficeLabel: UILabel = {
        let label = UILabel()
        label.text = "박스오피스"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let boxOfficeRankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let audiAcc: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let audiAccLabel: UILabel = {
        let label = UILabel()
        label.text = "누적관객수"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let audiAccStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    //전일대비 순위의 증감분
    let rankInten: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rankIntenLabel: UILabel = {
        let label = UILabel()
        label.text = "전일 대비"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rankIntenStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let movieInfoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 30
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let directorLabel: UILabel = {
        let label = UILabel()
        label.text = "감독"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let directorImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "Director")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let directorName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let actorLabel: UILabel = {
        let label = UILabel()
        label.text = "출연진"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let actorName: UILabel = {
        let label = UILabel()
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 10
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        
        [boxOfficeRank, boxOfficeLabel].forEach {
            self.boxOfficeRankStackView.addArrangedSubview($0)
        }
        
        [audiAcc, audiAccLabel].forEach {
            self.audiAccStackView.addArrangedSubview($0)
        }
        
        [rankInten, rankIntenLabel].forEach {
            self.rankIntenStackView.addArrangedSubview($0)
        }
        
        [boxOfficeRankStackView, rankIntenStackView, audiAccStackView].forEach {
            self.movieInfoStackView.addArrangedSubview($0)
        }
        
        addView()
        configure()
    }

    required init?(coder NSCoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func addView() {
        addSubview(posterImageView)
        addSubview(auditsImageView)
        addSubview(movieName)
        addSubview(movieNameEn)
        addSubview(genres)
        addSubview(openDate)
        addSubview(showTime)
        addSubview(prdtYear)
        
        addSubview(lineView)
        lineView.addSubview(movieInfoStackView)
        
        addSubview(directorLabel)
        addSubview(directorImageView)
        addSubview(directorName)
        
        addSubview(actorLabel)
        addSubview(actorName)
    }
    
    func configure() {
        NSLayoutConstraint.activate([
        
            posterImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            posterImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            posterImageView.heightAnchor.constraint(equalToConstant: 130),
            posterImageView.widthAnchor.constraint(equalToConstant: 90),

            auditsImageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            auditsImageView.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            auditsImageView.widthAnchor.constraint(equalToConstant: 20),
            auditsImageView.heightAnchor.constraint(equalToConstant: 20),
            
            movieName.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 20),
            movieName.leadingAnchor.constraint(equalTo: auditsImageView.trailingAnchor, constant: 5),
            movieName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            movieNameEn.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 5),
            movieNameEn.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            movieNameEn.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            genres.topAnchor.constraint(equalTo: movieNameEn.bottomAnchor, constant: 5),
            genres.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
            
            showTime.topAnchor.constraint(equalTo: movieNameEn.bottomAnchor, constant: 5),
            showTime.leadingAnchor.constraint(equalTo: genres.trailingAnchor),
            
            openDate.topAnchor.constraint(equalTo: genres.bottomAnchor, constant: 5),
            openDate.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 20),
                        
            prdtYear.topAnchor.constraint(equalTo: genres.bottomAnchor, constant: 5),
            prdtYear.leadingAnchor.constraint(equalTo: openDate.trailingAnchor),
            
            lineView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 10),
            lineView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            lineView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20),
            lineView.heightAnchor.constraint(equalToConstant: 100),
            
            movieInfoStackView.centerXAnchor.constraint(equalTo: lineView.centerXAnchor),
            movieInfoStackView.centerYAnchor.constraint(equalTo: lineView.centerYAnchor),
            
            directorLabel.topAnchor.constraint(equalTo: lineView.bottomAnchor, constant: 20),
            directorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            directorImageView.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 10),
            directorImageView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 30),
            directorImageView.widthAnchor.constraint(equalToConstant: 50),
            directorImageView.heightAnchor.constraint(equalToConstant: 50),
            
            directorName.leadingAnchor.constraint(equalTo: directorImageView.trailingAnchor, constant: 5),
            directorName.centerYAnchor.constraint(equalTo: directorImageView.centerYAnchor),
        
            actorLabel.topAnchor.constraint(equalTo: directorImageView.bottomAnchor, constant: 20),
            actorLabel.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            
            actorName.topAnchor.constraint(equalTo: actorLabel.bottomAnchor, constant: 10),
            actorName.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 20),
            actorName.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -20)
        ])
    }
}

