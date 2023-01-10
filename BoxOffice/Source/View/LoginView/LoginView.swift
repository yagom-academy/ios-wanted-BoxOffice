//
//  LoginView.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/06.
//

import UIKit

class LoginView: UIView {
    // MARK: properties
    let userImageButton: UIButton = {
        let button = UIButton()
        let config = UIImage.SymbolConfiguration(pointSize: 100)
        let image = UIImage(systemName: "person.crop.circle", withConfiguration: config)
        button.setImage(image, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let nickNameLabel: UILabel = {
        let label = UILabel()
        label.text = "별명"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nickNameTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray4
        textView.layer.cornerRadius = 5
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let passwordLabel: UILabel = {
        let label = UILabel()
        label.text = "암호"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let passwordTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray4
        textView.layer.cornerRadius = 5
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let starScoreLabel: UILabel = {
        let label = UILabel()
        label.text = "별점"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let oneStarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star.fill"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let twoStarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let threeStarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let fourStarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let fiveStarButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "star"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "내용"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let contentTextView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .systemGray4
        textView.layer.cornerRadius = 5
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    let loginTotalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white
        
        configureView()
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private function
    private func configureView() {
        self.addSubview(loginTotalStackView)
        
        loginTotalStackView.addArrangedSubview(userImageButton)
        loginTotalStackView.addArrangedSubview(nickNameLabel)
        loginTotalStackView.addArrangedSubview(nickNameTextView)
        loginTotalStackView.addArrangedSubview(passwordLabel)
        loginTotalStackView.addArrangedSubview(passwordTextView)
        loginTotalStackView.addArrangedSubview(starScoreLabel)
        loginTotalStackView.addArrangedSubview(starStackView)
        loginTotalStackView.addArrangedSubview(contentLabel)
        loginTotalStackView.addArrangedSubview(contentTextView)
        
        starStackView.addArrangedSubview(oneStarButton)
        starStackView.addArrangedSubview(twoStarButton)
        starStackView.addArrangedSubview(threeStarButton)
        starStackView.addArrangedSubview(fourStarButton)
        starStackView.addArrangedSubview(fiveStarButton)
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            loginTotalStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            loginTotalStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            loginTotalStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            
            nickNameTextView.heightAnchor.constraint(equalToConstant: 40),
            passwordTextView.heightAnchor.constraint(equalToConstant: 40),
            starStackView.heightAnchor.constraint(equalToConstant: 40),
            contentTextView.heightAnchor.constraint(equalToConstant: 200),

        ])
    }
}
