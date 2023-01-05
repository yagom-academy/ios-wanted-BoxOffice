//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by 천승희 on 2023/01/03.
//

import UIKit

class BoxOfficeCollectionViewCell: UICollectionViewCell {
    static let identify = "cell"
    var count = 0
    var boxofficeData: DailyBoxOfficeList?
    
    let rankLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let filmNameLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byTruncatingTail
        label.numberOfLines = 2
        return label
    }()

    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let spectatorsLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()

    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        return imageView
    }()
    
    let rankFluctuationsButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.black.cgColor
        button.layer.cornerRadius = 5
        button.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        
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
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createBoxOfficeCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func createBoxOfficeCell() {
        [rankLabel, filmNameLabel, releaseDateLabel, spectatorsLabel, posterImageView, rankFluctuationsButton, newRankButton].forEach {
            contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate([
            posterImageView.widthAnchor.constraint(equalToConstant: 90),
            posterImageView.heightAnchor.constraint(equalToConstant: 130),
            posterImageView.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            posterImageView.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            
            rankLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            rankLabel.trailingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: -5),
            
            rankFluctuationsButton.widthAnchor.constraint(equalToConstant: 35),
            rankFluctuationsButton.heightAnchor.constraint(equalToConstant: 20),
            rankFluctuationsButton.topAnchor.constraint(equalTo: posterImageView.topAnchor, constant: 10),
            rankFluctuationsButton.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -20),
            
            newRankButton.widthAnchor.constraint(equalToConstant: 35),
            newRankButton.heightAnchor.constraint(equalToConstant: 20),
            newRankButton.topAnchor.constraint(equalTo: rankFluctuationsButton.bottomAnchor, constant: 10),
            newRankButton.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: -20),
            
            filmNameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5),
            filmNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            filmNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            releaseDateLabel.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 5),
            releaseDateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            spectatorsLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 5),
            spectatorsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    
    func getFilmDetailData(movieCode: String, completion: @escaping (Result<FilmDetails, Error>) -> Void) {
//        print(movieCode)
        let url = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=635cb0b1404820f91c8a45fcdf831615&movieCd=\(movieCode)"
        NetworkManager().getData(url: url, completion: completion)
        
    }
    
    func getPosterData(movieName: String, completion: @escaping (Result<FilmPoster, Error>) -> Void) {
//        filmEnglishName?.replacingOccurrences(of: " ", with: "+")
        let url = "https://omdbapi.com/?apikey=54346b2b&t=\(movieName.replacingOccurrences(of: " ", with: "+"))"
        NetworkManager().getData(url: url, completion: completion)
        
    }
    
    
    func configBoxOfficeCell(data: DailyBoxOfficeList) {
        boxofficeData = data
        guard let rankInten = Int(data.rankInten) else {
            return
        }
        
        getFilmDetailData(movieCode: data.movieCd) { result in
            switch result {
            case .success(let success):
                self.getPosterData(movieName: success.movieInfoResult.movieInfo.movieNmEn) { result in
                    switch result {
                    case .success(let success):
                        ImageManager.loadImage(from: success.poster) { image in
                            self.posterImageView.image = image
                        }
                    case .failure(let failure):
                        print(failure   )
                    }
                }
            case .failure(let failure):
                print(failure   )
            }
        }
        
        rankLabel.text = data.rank
        if data.rankOldAndNew == "NEW" {
            newRankButton.alpha = 1
            newRankButton.setTitle(data.rankOldAndNew, for: .normal)
        }
    
        if rankInten == 0 {
            print(data.movieNm)
            rankFluctuationsButton.setTitle("-", for: .normal)
            rankFluctuationsButton.setTitleColor(.gray, for: .normal)
        } else if rankInten > 0 {
            print(data.movieNm)
            rankFluctuationsButton.setTitle("\(rankInten)", for: .normal)
            rankFluctuationsButton.setImage(UIImage(systemName: "chevron.up"), for: .normal)
            rankFluctuationsButton.tintColor = .red
            rankFluctuationsButton.setTitleColor(.red, for: .normal)
        } else {
            print(data.movieNm)
            rankFluctuationsButton.setTitle("\(abs(rankInten))", for: .normal)
            rankFluctuationsButton.setImage(UIImage(systemName: "chevron.down"), for: .normal)
            rankFluctuationsButton.tintColor = .blue
            rankFluctuationsButton.setTitleColor(.blue, for: .normal)
        }
        filmNameLabel.text = data.movieNm
        releaseDateLabel.text = data.openDt
        spectatorsLabel.text = data.audiAcc
    }
}
