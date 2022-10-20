//
//  ReviewView.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/20.
//

import UIKit

class ReviewView: UIView {
    
    let starScore: StarScore = {
        let view = StarScore()
        view.scoreTitleLabel.text = "별점"
        view.isUserInteractionEnabled = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let uploadImageButton: UIButton = {
        let view = UIButton()
        let origImage = UIImage(named: "add_photo")
        let tintedImage = origImage?.withRenderingMode(.alwaysTemplate)
        view.setImage(tintedImage, for: .normal)
        view.tintColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1.00)
        view.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        view.imageView?.contentMode = .scaleAspectFill
        view.imageView?.backgroundColor = .white
        view.layer.cornerRadius = 0.5 * view.bounds.size.width
        view.layer.borderWidth = 2
        view.layer.borderColor = UIColor(red: 0.59, green: 0.59, blue: 0.59, alpha: 1.00).cgColor
        view.contentEdgeInsets = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        view.clipsToBounds = true
        view.backgroundColor = UIColor(red: 0.95, green: 0.95, blue: 0.95, alpha: 1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nicknameLabel: UILabel = {
        let view = UILabel()
        view.text = "별명"
        view.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nicknameTextField: UITextField = {
        let view = UITextField()
        view.tag = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordLabel: UILabel = {
        let view = UILabel()
        view.text = "암호"
        view.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let passwordTextField: UITextField = {
        let view = UITextField()
        view.tag = 1
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    var asterisks: [UILabel] = []
    
    let reviewTextView: UITextView = {
        let view = UITextView()
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.00).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let reviewButton: UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor(named: "customPurple")
        view.setTitle("리뷰작성완료", for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        makeAsterisk()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupConstraints() {
        
        addSubview(starScore)
        addSubview(uploadImageButton)
        addSubview(nicknameLabel)
        addSubview(nicknameTextField)
        addSubview(passwordLabel)
        addSubview(passwordTextField)
        addSubview(asterisks[0])
        addSubview(asterisks[1])
        addSubview(reviewTextView)
        addSubview(reviewButton)
        
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            starScore.topAnchor.constraint(equalTo: safeArea.topAnchor),
            starScore.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 20),
            starScore.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -20),
            
            uploadImageButton.topAnchor.constraint(equalTo: starScore.bottomAnchor, constant: 20),
            uploadImageButton.centerXAnchor.constraint(equalTo: safeArea.centerXAnchor),
            uploadImageButton.widthAnchor.constraint(equalToConstant: 80),
            uploadImageButton.heightAnchor.constraint(equalToConstant: 80),
            
            nicknameLabel.topAnchor.constraint(equalTo: uploadImageButton.bottomAnchor, constant: 20),
            nicknameLabel.leadingAnchor.constraint(equalTo: nicknameTextField.leadingAnchor),
            
            nicknameTextField.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 8),
            nicknameTextField.centerXAnchor.constraint(equalTo: centerXAnchor),
            nicknameTextField.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),
            
            passwordLabel.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 8),
            passwordLabel.leadingAnchor.constraint(equalTo: nicknameTextField.leadingAnchor),
            
            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 8),
            passwordTextField.leadingAnchor.constraint(equalTo: nicknameTextField.leadingAnchor),
            passwordTextField.widthAnchor.constraint(equalTo: nicknameTextField.widthAnchor),
            
            asterisks[0].topAnchor.constraint(equalTo: nicknameLabel.topAnchor),
            asterisks[0].leadingAnchor.constraint(equalTo: nicknameLabel.trailingAnchor),
            
            asterisks[1].topAnchor.constraint(equalTo: passwordLabel.topAnchor),
            asterisks[1].leadingAnchor.constraint(equalTo: passwordLabel.trailingAnchor),
            
            reviewTextView.topAnchor.constraint(equalTo: passwordTextField.bottomAnchor, constant: 44),
            reviewTextView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            reviewTextView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            reviewTextView.bottomAnchor.constraint(equalTo: reviewButton.topAnchor, constant: -20),
            
            reviewButton.leadingAnchor.constraint(equalTo:leadingAnchor),
            reviewButton.trailingAnchor.constraint(equalTo:trailingAnchor),
            reviewButton.heightAnchor.constraint(equalToConstant: 54),
            reviewButton.bottomAnchor.constraint(equalTo: bottomAnchor,constant: -20)
            
            
            
        ])
    }
    
    func makeAsterisk() {
        for _ in 0...1 {
            let view = UILabel()
            view.text = "*"
            view.textColor = .red
            view.translatesAutoresizingMaskIntoConstraints = false
            asterisks.append(view)
        }
    }
    
}

