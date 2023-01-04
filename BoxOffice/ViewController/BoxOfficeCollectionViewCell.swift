//
//  BoxOfficeCollectionViewCell.swift
//  BoxOffice
//
//  Created by 천승희 on 2023/01/03.
//

import UIKit

class BoxOfficeCollectionViewCell: UICollectionViewCell {
    static let identify = "cell"
    
    let rankLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let rankFluctuationsLabel: UILabel = {
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
        imageView.backgroundColor = .blue
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        createBoxOfficeCell()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func createBoxOfficeCell() {
        [rankLabel, rankFluctuationsLabel, filmNameLabel, releaseDateLabel, spectatorsLabel, posterImageView].forEach {
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
            
            rankFluctuationsLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            rankFluctuationsLabel.leadingAnchor.constraint(equalTo: posterImageView.trailingAnchor, constant: 4),
            
            filmNameLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 5),
            filmNameLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            filmNameLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            releaseDateLabel.topAnchor.constraint(equalTo: filmNameLabel.bottomAnchor, constant: 5),
            releaseDateLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            spectatorsLabel.topAnchor.constraint(equalTo: releaseDateLabel.bottomAnchor, constant: 5),
            spectatorsLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
        ])
    }
    
    func configBoxOfficeCell(data: DailyBoxOfficeList) {
        rankLabel.text = data.rank
        if data.rankOldAndNew == "NEW" {
            rankFluctuationsLabel.text = data.rankOldAndNew
        } else {
            if data.rankInten == "0" {
                rankFluctuationsLabel.text = ""
            } else {
                rankFluctuationsLabel.text = data.rankInten
            }
        }
        filmNameLabel.text = data.movieNm
        releaseDateLabel.text = data.openDt
        spectatorsLabel.text = data.audiAcc
    }
    
    func configImage(data: Search) {
        ImageManager.loadImage(from: data.poster) { image in
            self.posterImageView.image = image
        }
    }
}
