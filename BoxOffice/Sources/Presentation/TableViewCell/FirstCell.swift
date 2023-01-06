//
//  FirstCell.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/03.
//

import UIKit

class FirstCell: UITableViewCell {
    private lazy var posterImageView: UIImageView = {
        let view = UIImageView(image: UIImage(named: "ironman.jpg"))
        view.heightAnchor.constraint(equalToConstant: 325).isActive = true
        view.backgroundColor = .purple
        return view
    }()
    
    private lazy var titledatetimeageStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .leading
        stackview.distribution = .equalSpacing
        stackview.spacing = 2
        return stackview
    }()
    
    private lazy var updownRankingStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .equalSpacing
        stackview.spacing = 4
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
        stackview.distribution = .equalSpacing
        stackview.spacing = 9
        return stackview
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.textColor = .white
        label.numberOfLines = 2
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
        view.backgroundColor = .boBackground
        view.tintColor = .white
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAutolayout()
        contentView.backgroundColor = .boBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAutolayout() {
        contentView.addSubviews(posterImageView, titledatetimeageStackView, shareImageView)
        
        updownRankingStackView.addArrangedSubviews(updownImageView, updownNumberLabel)
        
        titleupdownStackView.addArrangedSubviews(titleLabel, updownRankingStackView)
        
        datetimeageStackView.addArrangedSubviews(releaseDatelabel, runningTimeLabel, ageLabel)
        
        titledatetimeageStackView.addArrangedSubviews(titleupdownStackView, datetimeageStackView)
        
        NSLayoutConstraint.activate([
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 30),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 64),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -64)
        ])
        
        NSLayoutConstraint.activate([
            titledatetimeageStackView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 29),
            titledatetimeageStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            titledatetimeageStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -15)
        ])
        
        NSLayoutConstraint.activate([
            shareImageView.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 34),
            shareImageView.leadingAnchor.constraint(equalTo: titledatetimeageStackView.trailingAnchor, constant: 110),
            shareImageView.heightAnchor.constraint(equalToConstant: 20),
            shareImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15)
        ])
    }
    
    func transferData(_ name: String, _ detailInfo: MovieDetailInfo, _ boxOfficeInfo: BoxOfficeInfo) {
        posterImageView.image = ImageCacheManager.shared.loadCachedData(for: detailInfo.poster!)!
        if boxOfficeInfo.rankOldAndNew == .new {
            updownNumberLabel.text = boxOfficeInfo.rankOldAndNew.rawValue
        } else {
            if boxOfficeInfo.rankInten < 0 {
                updownImageView.image = UIImage(systemName: "arrowtriangle.down.fill")
                updownImageView.tintColor = .blue
            }
            
            updownNumberLabel.text = "\( abs(boxOfficeInfo.rankInten))"
        }
        titleLabel.text = name
        releaseDatelabel.text = detailInfo.productionYear
        runningTimeLabel.text =
        "\(detailInfo.showTime)분"
        ageLabel.text = detailInfo.audit
    }
}
