//
//  StarScore.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/20.
//

import UIKit

class StarScore: UIView {
    
    var currentStar: Int = 0
    var score: Int = 0 {
        didSet {
            scoreLabel.text = "\(score) / 5"
        }
    }
    
    lazy var starStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fillEqually
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var starFillImage: UIImage? = {
        return UIImage(named: "fill_star")
    }()
    
    lazy var starEmptyImage: UIImage? = {
        return UIImage(named: "empty_star")
    }()
    
    let scoreTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "별점 평균"
        view.textAlignment = .center
        view.font = .boldSystemFont(ofSize: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scoreLabel: UILabel = {
        let view = UILabel()
        view.text = "0 / 5"
        view.textAlignment = .center
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var buttons: [starButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        for i in 0 ..< 5 {
            let button = starButton()
            button.setImage(starEmptyImage, for: .normal)
            button.imageView?.contentMode = .scaleAspectFit
            button.tag = i
            buttons.append(button)
            starStackView.addArrangedSubview(button)
            starStackView.contentMode = .scaleAspectFit
            button.addTarget(self, action: #selector(starButtonClicked(sender:)), for: .touchUpInside)
        }
    }
    
    func setupConstraints() {
        addSubview(scoreTitleLabel)
        addSubview(starStackView)
        addSubview(scoreLabel)
        NSLayoutConstraint.activate([
            
            scoreTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            scoreTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            scoreTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            
            starStackView.topAnchor.constraint(equalTo: scoreTitleLabel.bottomAnchor, constant: 20),
            starStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            starStackView.heightAnchor.constraint(equalTo: starStackView.widthAnchor, multiplier: 0.2),
            
            scoreLabel.topAnchor.constraint(equalTo: starStackView.bottomAnchor, constant: 20),
            scoreLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            scoreLabel.trailingAnchor.constraint(equalTo: trailingAnchor),
            scoreLabel.bottomAnchor.constraint(equalTo: bottomAnchor,constant: 20)
        
            
        ])
        
    }
    
    @objc func starButtonClicked(sender: starButton) {
        
        let end = sender.tag
        
        if sender.isOn {
            if buttons[safe: end + 1] == nil {
                for i in end..<5 {
                    buttons[i].setImage(starEmptyImage, for: .normal)
                    buttons[i].isOn = false
                }
            } else {
                if buttons[end + 1].isOn {
                    for i in end + 1..<5 {
                        buttons[i].setImage(starEmptyImage, for: .normal)
                        buttons[i].isOn = false
                    }
                } else {
                    for i in end..<5 {
                        buttons[i].setImage(starEmptyImage, for: .normal)
                        buttons[i].isOn = false
                    }
                }
            }
            
            
        } else {
            for i in 0...end {
                buttons[i].setImage(starFillImage, for: .normal)
                buttons[i].isOn = true
            }
            for i in end + 1..<5 {
                buttons[i].setImage(starEmptyImage, for: .normal)
                buttons[i].isOn = false
            }
        }
        
        self.score = outputScore()

    }
    
    func inputScore(score: Int) {
        
        self.score = score
        
        for i in 1...score {
            buttons[i].setImage(starFillImage, for: .normal)
            buttons[i].isOn = true
        }
        for i in score..<5 {
            buttons[i].setImage(starEmptyImage, for: .normal)
            buttons[i].isOn = false
        }
    }
    
    func outputScore() -> Int {
        var score = 0
        buttons.forEach { starButton in
            if starButton.isOn { score += 1 }
        }
        return score
    }
    
}

class starButton: UIButton {
    
    var isOn: Bool = false
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
}
