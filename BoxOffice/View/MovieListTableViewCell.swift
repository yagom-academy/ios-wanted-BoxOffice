//
//  MovieListTableViewCell.swift
//  BoxOffice
//
//  Created by 이은찬 on 2023/01/06.
//

import UIKit

class MovieListTableViewCell: UITableViewCell {
    
    private let poster: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.borderWidth = 0.2
        
        return imageView
    }()
    
    private let movieRank: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        
        return label
    }()
    
    private let movieName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        
        return label
    }()
    
    private let movieOpenDate: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let movieShowCount: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        
        return label
    }()
    
    private let movieUpdatedRank: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        label.clipsToBounds = true
        label.layer.cornerRadius = 9
        label.textAlignment = .center
        
        return label
    }()
    
    private let movieOldOrNew: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.clipsToBounds = true
        label.layer.cornerRadius = 5
        label.textAlignment = .center
        label.textColor = .white
        label.backgroundColor = .green
        
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupSubviews() {
        addSubview(poster)
        addSubview(movieRank)
        addSubview(movieName)
        addSubview(movieOpenDate)
        addSubview(movieShowCount)
        addSubview(movieUpdatedRank)
        addSubview(movieOldOrNew)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            poster.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            poster.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            poster.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            poster.heightAnchor.constraint(greaterThanOrEqualToConstant: 100),
            poster.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.35),
            
            movieRank.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 5),
            movieRank.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            
            movieUpdatedRank.leadingAnchor.constraint(equalTo: movieRank.trailingAnchor, constant: 5),
            movieUpdatedRank.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            movieUpdatedRank.widthAnchor.constraint(greaterThanOrEqualToConstant: 20),
            
            movieOldOrNew.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            movieOldOrNew.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            movieName.topAnchor.constraint(equalTo: movieRank.bottomAnchor, constant: 5),
            movieName.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 5),
            movieName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            movieOpenDate.topAnchor.constraint(equalTo: movieName.bottomAnchor, constant: 5),
            movieOpenDate.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 5),
            movieOpenDate.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            
            movieShowCount.topAnchor.constraint(equalTo: movieOpenDate.bottomAnchor, constant: 5),
            movieShowCount.leadingAnchor.constraint(equalTo: poster.trailingAnchor, constant: 5),
            movieShowCount.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
            movieShowCount.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }
    
    func configure(movie: MovieEssentialInfo) {
        DispatchQueue.global().async {
            guard let url = URL(string: movie.posterUrl),
                  let data = try? Data(contentsOf: url) else { return }
            DispatchQueue.main.async {
                self.poster.image = UIImage(data: data)
            }
        }
        movieRank.text = "\(movie.rank )위"
        movieName.text = movie.movieNm
        movieOpenDate.text = "개봉일 : \(movie.openDt)"
        movieShowCount.text = "관객 수 : \(movie.audiAcc)"
        changeBackgourndOfUpdateRank(movie.rankInten)
        movieUpdatedRank.text = "(\(movie.rankInten))"
        appendNewLabel(movie.rankOldAndNew)
    }
    
    private func changeBackgourndOfUpdateRank(_ number: String?) {
        guard let rankInten = Int(number ?? "") else { return }
        if rankInten > 0 {
            movieUpdatedRank.backgroundColor = .green
        } else if rankInten < 0 {
            movieUpdatedRank.backgroundColor = .red
        } else {
            movieUpdatedRank.isHidden = true
        }
    }
    
    private func appendNewLabel(_ value: String?) {
        guard let value = value else { return }
        
        switch value {
        case "OLD":
            movieOldOrNew.isHidden = true
        case "NEW":
            movieOldOrNew.text = value
            movieOldOrNew.backgroundColor = .green
            movieOldOrNew.textColor = .white
        default:
            return
        }
    }
}
