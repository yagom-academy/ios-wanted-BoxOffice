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
        
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let spectatorsLabel: UILabel = {
        let label = UILabel()
        
        return label
    }()
    
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        
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
            self.contentView.addSubview($0)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        NSLayoutConstraint.activate([
            rankLabel.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        ])
    }
    
    func configBoxOfficeCell(data: DailyBoxOfficeList) {
        rankLabel.text = data.rank
        rankFluctuationsLabel.text = data.rankInten
        filmNameLabel.text = data.movieNm
        releaseDateLabel.text = data.openDt
        spectatorsLabel.text = data.audiAcc
    }
}
