//
//  ThirdCell.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/03.
//

import UIKit

class ThirdCell: UITableViewCell {
    
    private lazy var backgroundStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fillEqually, spacing: 4)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 20, leading: 20, bottom: 20, trailing: 20)
        stackView.addArrangedSubviews(genreStackView, directorStackView, actorStackView, productionyearStackView)
        return stackView
    }()
    
    private lazy var genreStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .leading
        stackview.distribution = .fill
        stackview.spacing = 6
        stackview.addArrangedSubviews(genreLabel, genresLabel)
        return stackview
    }()
    
    private lazy var genreLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        label.text = "장르"
        return label
    }()
    
    private lazy var genresLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        label.text = "액션, 어드벤쳐"
        return label
    }()
    
    private lazy var directorStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .leading
        stackview.distribution = .fill
        stackview.spacing = 6
        stackview.addArrangedSubviews(directorLabel, directorsLabel)
        return stackview
    }()
    
    private lazy var directorLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
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
        stackview.alignment = .leading
        stackview.distribution = .fill
        stackview.spacing = 6
        stackview.addArrangedSubviews(actorLabel, actorsLabel)
        return stackview
    }()
    
    private lazy var actorLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.text = "주연"
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
        return label
    }()
    
    private lazy var actorsLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 13)
        label.textColor = .white
        label.text = "asdasd, asdasdasd, asdasd"
        label.numberOfLines = 2
        label.numberOfLines = 1
        label.textAlignment = .left
        return label
    }()
    
    private lazy var productionyearStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .leading
        stackview.distribution = .fill
        stackview.spacing = 6
        stackview.addArrangedSubviews(productionyearLabel, productionyearsLabel)
        return stackview
    }()
    
    private lazy var productionyearLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 15)
        label.textColor = .white
        label.setContentHuggingPriority(.required, for: .horizontal)
        label.setContentCompressionResistancePriority(.required, for: .horizontal)
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
    
    private(set) lazy var reviewButton: UIButton = {
        let button = UIButton()
        button.tintColor = .white
        button.backgroundColor = .systemIndigo
        button.setTitle("리뷰하기", for: .normal)
        button.titleLabel?.textColor = .white
        button.layer.cornerRadius = 10
        return button
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
        contentView.addSubviews(backgroundStackView, reviewButton)
        NSLayoutConstraint.activate([
            backgroundStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundStackView.bottomAnchor.constraint(equalTo: reviewButton.topAnchor),
            reviewButton.topAnchor.constraint(equalTo: backgroundStackView.bottomAnchor),
            reviewButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            reviewButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            reviewButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -20),
            reviewButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    func transferData(_ detailInfo: MovieDetailInfo) {
        var genres = String()
        var directors = String()
        var actors = String()
        detailInfo.genres.forEach {
            genres += ("\($0),")
        }
        detailInfo.directors.forEach {
            directors += ("\($0),")
        }
        if  detailInfo.actors.count != 0 {
            detailInfo.actors.forEach {
                actors += ("\($0),")
            }
            actors.removeLast()
        } else {
            actors = "-"
        }
        
        if  detailInfo.directors.count != 0 {
            detailInfo.directors.forEach {
                directors += ("\($0),")
            }
            directors.removeLast()
        } else {
            directors = "-"
        }
        
        genres.removeLast()
        
        genresLabel.text = genres
        directorsLabel.text = directors
        actorsLabel.text = actors
        productionyearsLabel.text = detailInfo.productionYear
    }
}

