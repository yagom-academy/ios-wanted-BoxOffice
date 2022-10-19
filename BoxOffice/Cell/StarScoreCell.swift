//
//  StarScoreCell.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/20.
//

import UIKit

class StarScoreCell: UITableViewCell {
    
    static var identifier: String = String(describing: StarScoreCell.self)
    var buttonAction: ( () -> Void ) = {}
    
    let starScoreTitleLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 20)
        view.textAlignment = .center
        view.text = "평균별점"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let starScore: StarScore = {
        let view = StarScore()
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let reviewButton: UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named: "write"), for: .normal)
        view.backgroundColor = UIColor(named: "customPurple")
        view.setTitle("리뷰 작성", for: .normal)
        view.titleLabel?.font = .systemFont(ofSize: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupConstraints()
        
        reviewButton.addTarget(self, action: #selector(buttonClicked), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        contentView.addSubview(starScore)
        contentView.addSubview(reviewButton)
        NSLayoutConstraint.activate([
            
            starScore.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            starScore.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            starScore.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.3),
            
            reviewButton.topAnchor.constraint(equalTo: starScore.bottomAnchor, constant: 46),
            reviewButton.leadingAnchor.constraint(equalTo:contentView.leadingAnchor),
            reviewButton.trailingAnchor.constraint(equalTo:contentView.trailingAnchor),
            reviewButton.heightAnchor.constraint(equalToConstant: 54),
            reviewButton.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20)
        ])
    }
    
    @objc func buttonClicked() {
        buttonAction()
    }
}
