//
//  MovieReviewViewController.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/05.
//

import UIKit

final class MovieReviewViewController: UIViewController {

    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "영화 어떠셨나요?"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private let starButton1 = UIButton()
    private let starButton2 = UIButton()
    private let starButton3 = UIButton()
    private let starButton4 = UIButton()
    private let starButton5 = UIButton()

    private lazy var starButtons = [starButton1, starButton2, starButton3, starButton4, starButton5]
    
    private lazy var starsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        starButtons.forEach { stackView.addArrangedSubview($0) }
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let reviewRequestLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "관람평을 남겨주세요."
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
    
    private let userInformationStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let userInformationRequestLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "어떤 닉네임으로 리뷰를 등록해드릴까요?"
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .footnote)
        return label
    }()
        
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "닉네임"
        return label
    }()
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "닉네임을 입력해주세요."
        textField.textAlignment = .left
        return textField
    }()
    
    private let passwordLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "비밀번호"
        return label
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.placeholder = "비밀번호를 입력해주세요."
        textField.textAlignment = .left
        return textField
    }()
    
    private let passwordRuleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = """
        비밀번호는 알파벳 소문자, 숫자, 그리고 특수 문자(!, @, #, $)를 각 1개 이상 포함하고, 6자리 이상, 20자리 이하여야 합니다.
        """
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.font = .preferredFont(forTextStyle: .caption2)
        return label
    }()
    
    private let reviewTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    private let photoAddingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.tintColor = .black
        button.setTitle("  사진 추가하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
        
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        return button
    }()
    
    private let actionButtonStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupStarButtons()
        
        addViews()
        setupLayout()
    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nicknameTextField.setUnderLine(width: 1, color: .tertiaryLabel)
        passwordTextField.setUnderLine(width: 1, color: .tertiaryLabel)
    }
    
    private func setupStarButtons() {
        let sizeConfiguration = UIImage.SymbolConfiguration(pointSize: 35)
        
        starButtons.forEach { star in
            star.setImage(UIImage(systemName: "star", withConfiguration: sizeConfiguration), for: .normal)
            star.setImage(UIImage(systemName: "star.fill", withConfiguration: sizeConfiguration), for: .selected)
            star.tintColor = .systemYellow
        }
    }
    
    private func addViews() {
        [
            questionLabel,
            reviewRequestLabel,
            reviewTextView,
            photoAddingButton,
            userInformationRequestLabel,
            nicknameLabel,
            nicknameTextField,
            passwordLabel,
            passwordTextField,
            passwordRuleLabel,
        ].forEach( { view.addSubview($0) })
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            questionLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            reviewRequestLabel.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 50),
            reviewRequestLabel.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            
            reviewTextView.topAnchor.constraint(equalTo: reviewRequestLabel.bottomAnchor, constant: 8),
            reviewTextView.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            reviewTextView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            reviewTextView.heightAnchor.constraint(equalToConstant: 100),

            photoAddingButton.topAnchor.constraint(equalTo: reviewTextView.bottomAnchor, constant: 8),
            photoAddingButton.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            photoAddingButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            photoAddingButton.heightAnchor.constraint(equalToConstant: 50),
            
            userInformationRequestLabel.topAnchor.constraint(equalTo: photoAddingButton.bottomAnchor, constant: 60),
            userInformationRequestLabel.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            
            nicknameLabel.topAnchor.constraint(equalTo: userInformationRequestLabel.bottomAnchor, constant: 16),
            nicknameLabel.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            
            nicknameTextField.topAnchor.constraint(equalTo: nicknameLabel.topAnchor),
            nicknameTextField.leadingAnchor.constraint(equalTo: nicknameLabel.trailingAnchor, constant: 32),
            nicknameTextField.widthAnchor.constraint(equalToConstant: 200),
            
            passwordLabel.topAnchor.constraint(equalTo: nicknameTextField.bottomAnchor, constant: 16),
            passwordLabel.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),

            passwordTextField.topAnchor.constraint(equalTo: passwordLabel.topAnchor),
            passwordTextField.leadingAnchor.constraint(equalTo: passwordLabel.trailingAnchor, constant: 16),
            passwordTextField.widthAnchor.constraint(equalToConstant: 200),
            
            passwordRuleLabel.topAnchor.constraint(equalTo: passwordLabel.bottomAnchor, constant: 16),
            passwordRuleLabel.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            passwordRuleLabel.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
        ])
    }
}

fileprivate extension UITextField {
    func setUnderLine(width: CGFloat, color: UIColor) {
        let border = CALayer()
        border.borderColor = color.cgColor
        border.frame = CGRect(x: 0, y: self.frame.size.height - width, width:  self.frame.size.width - 10, height: self.frame.size.height)
        border.borderWidth = width
        self.layer.addSublayer(border)
        self.layer.masksToBounds = true
    }
}
