//
//  ThirdCell.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/03.
//

import UIKit

class ThirdCell: UITableViewCell {
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
        button.layer.borderColor = UIColor(r: 50, g: 50, b: 50).cgColor
        return button
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAutolayout()
        contentView.backgroundColor = UIColor(r: 26, g: 26, b: 26)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAutolayout() {
        contentView.addSubviews(genreStackView, directorStackView, actorStackView, productionyearStackView, reviewButton)
        
        genreStackView.addArrangedSubviews(genreLabel, genresLabel)
        
        directorStackView.addArrangedSubviews(directorLabel, directorsLabel)
        
        actorStackView.addArrangedSubviews(actorLabel, actorsLabel)
        
        productionyearStackView.addArrangedSubviews(productionyearLabel, productionyearsLabel)
        
        NSLayoutConstraint.activate([
            genreStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            genreStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            genreStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            directorStackView.topAnchor.constraint(equalTo: genreStackView.bottomAnchor, constant: 4),
            directorStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            directorStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            actorStackView.topAnchor.constraint(equalTo: directorStackView.bottomAnchor, constant: 4),
            actorStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            actorStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            productionyearStackView.topAnchor.constraint(equalTo: actorStackView.bottomAnchor, constant: 4),
            productionyearStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            productionyearStackView.heightAnchor.constraint(equalToConstant: 20)
        ])
        
        NSLayoutConstraint.activate([
            reviewButton.topAnchor.constraint(equalTo: productionyearStackView.bottomAnchor, constant: 15),
            reviewButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 7),
            reviewButton.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -7),
            reviewButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
}
