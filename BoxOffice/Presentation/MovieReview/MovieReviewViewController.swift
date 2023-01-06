//
//  MovieReviewViewController.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/05.
//

import UIKit

final class MovieReviewViewController: UIViewController {
    
    private let viewModel: MovieReviewViewModel
    
    private let movieCode: String
    private var rating: Double = 0
    
    private let imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        return imagePicker
    }()

    private let outerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .onDrag
        return scrollView
    }()
    
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
    
    private lazy var starButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        starButtons.forEach { stackView.addArrangedSubview($0) }
        stackView.axis = .horizontal
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    private let photoImageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
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
    
    private let reviewTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.font = .preferredFont(forTextStyle: .body)
        textView.backgroundColor = .secondarySystemBackground
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    private lazy var photoAddingButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "camera"), for: .normal)
        button.tintColor = .label
        button.setTitle("  사진 추가하기", for: .normal)
        button.setTitleColor(.label, for: .normal)
                
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.layer.borderWidth = 1
        button.clipsToBounds = true
        
        button.addAction(UIAction(handler: { action in
            self.viewModel.photoAddingButtonTapped()
        }), for: .touchUpInside)
        return button
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
    
    private let actionButtonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.setTitle("취소", for: .normal)
        button.setTitleColor(.secondaryLabel, for: .normal)
        
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.layer.borderWidth = 1
        
        button.addAction(UIAction(handler: { action in
            self.presentingViewController?.dismiss(animated: true)
        }), for: .touchUpInside)
        return button
    }()
    
    private lazy var registrationButton: UIButton = {
        let button = UIButton()
        button.setTitle("등록", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .systemPurple
        
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemGray3.cgColor
        button.layer.borderWidth = 1
        
        button.addAction(UIAction(handler: { action in
            let movieReview = MovieReview(
                id: UUID(),
                movieCode: self.movieCode,
                user: User(nickname: self.nicknameTextField.text!),
                password: self.passwordTextField.text!,
                rating: self.rating,
                image: "",
                description: self.reviewTextView.text
            )
            self.viewModel.registrationButtonTapped(movieReview: movieReview)
        }), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        
        setupStarButtons()
        
        addViews()
        setupLayout()
        configureImagePicker()
        configureTextField()
        bind()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(hideKeyboard)))
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    @objc private func hideKeyboard() {
        self.view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height

        }
    }
    
    @objc private func keyboardWillHide() {

    }

    init(movieCode: String, viewModel: MovieReviewViewModel) {
        self.movieCode = movieCode
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        nicknameTextField.setUnderLine(width: 1, color: .tertiaryLabel)
        passwordTextField.setUnderLine(width: 1, color: .tertiaryLabel)
    }
    
    private func bind() {
        viewModel.presentImagePicker = { [weak self] in
            self?.present(self!.imagePicker, animated: true)
        }
    }
    
    private func setupStarButtons() {
        let sizeConfiguration = UIImage.SymbolConfiguration(pointSize: 35)
        
        starButtons.forEach { star in
            star.setImage(UIImage(systemName: "star", withConfiguration: sizeConfiguration), for: .normal)
            star.setImage(UIImage(systemName: "star.fill", withConfiguration: sizeConfiguration), for: .selected)
            star.tintColor = .systemYellow
        }
        
        configureStarButtonsAction()
    }
    

    private func configureStarButtonsAction() {
        starButton1.addAction(UIAction(handler: { action in
            self.starButton1.isSelected = true
            self.starButton2.isSelected = false
            self.starButton3.isSelected = false
            self.starButton4.isSelected = false
            self.starButton5.isSelected = false
            self.rating = 1
        }), for: .touchUpInside)
        
        starButton2.addAction(UIAction(handler: { action in
            self.starButton1.isSelected = true
            self.starButton2.isSelected = true
            self.starButton3.isSelected = false
            self.starButton4.isSelected = false
            self.starButton5.isSelected = false
            self.rating = 2
        }), for: .touchUpInside)
        
        starButton3.addAction(UIAction(handler: { action in
            self.starButton1.isSelected = true
            self.starButton2.isSelected = true
            self.starButton3.isSelected = true
            self.starButton4.isSelected = false
            self.starButton5.isSelected = false
            self.rating = 3
        }), for: .touchUpInside)
        
        starButton4.addAction(UIAction(handler: { action in
            self.starButton1.isSelected = true
            self.starButton2.isSelected = true
            self.starButton3.isSelected = true
            self.starButton4.isSelected = true
            self.starButton5.isSelected = false
            self.rating = 4
        }), for: .touchUpInside)
        
        starButton5.addAction(UIAction(handler: { action in
            self.starButton1.isSelected = true
            self.starButton2.isSelected = true
            self.starButton3.isSelected = true
            self.starButton4.isSelected = true
            self.starButton5.isSelected = true
            self.rating = 5
        }), for: .touchUpInside)
    }

    private func addViews() {
        view.addSubview(outerScrollView)
        [
            questionLabel,
            starButtonsStackView,
            reviewRequestLabel,
            photoImageStackView,
            reviewTextView,
            photoAddingButton,
            userInformationRequestLabel,
            nicknameLabel,
            nicknameTextField,
            passwordLabel,
            passwordTextField,
            passwordRuleLabel,
            actionButtonsStackView,
        ].forEach( { outerScrollView.addSubview($0) })
        
        actionButtonsStackView.addArrangedSubview(cancelButton)
        actionButtonsStackView.addArrangedSubview(registrationButton)
    }
    
    private func setupLayout() {
        NSLayoutConstraint.activate([
            outerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            outerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            outerScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            outerScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            questionLabel.topAnchor.constraint(equalTo: outerScrollView.topAnchor, constant: 80),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            starButtonsStackView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16),
            starButtonsStackView.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            
            reviewRequestLabel.topAnchor.constraint(equalTo: starButtonsStackView.bottomAnchor, constant: 50),
            reviewRequestLabel.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            
            photoImageStackView.topAnchor.constraint(equalTo: reviewRequestLabel.bottomAnchor, constant: 8),
            photoImageStackView.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            photoImageStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),

            reviewTextView.topAnchor.constraint(equalTo: photoImageStackView.bottomAnchor, constant: 8),
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

            actionButtonsStackView.topAnchor.constraint(equalTo: passwordRuleLabel.bottomAnchor, constant: 20),
            actionButtonsStackView.bottomAnchor.constraint(equalTo: outerScrollView.bottomAnchor),
            actionButtonsStackView.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            actionButtonsStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16),
            actionButtonsStackView.heightAnchor.constraint(equalToConstant: 50),
        ])
    }
}

extension MovieReviewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    private func configureImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else {
            return
        }
        
        viewModel.imageSelected(image: image)
        
        let imageView = UIImageView(image: image)
        imageView.layer.cornerRadius = 16
        imageView.heightAnchor.constraint(equalToConstant: 180).isActive = true
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 10
        imageView.backgroundColor = .systemGray6

        photoImageStackView.arrangedSubviews.forEach{ $0.removeFromSuperview() }
        photoImageStackView.addArrangedSubview(imageView)
        
        dismiss(animated: true)
    }
}

extension MovieReviewViewController: UITextFieldDelegate {
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
        guard let stringBeforeCurrentInput = textField.text else {
            return false
        }
        
        let passwordInput = stringBeforeCurrentInput + string
        
        if isValid(password: passwordInput) {
            passwordRuleLabel.isHidden = true
        } else {
            passwordRuleLabel.textColor = .red
        }
        
        return true
    }
    
    private func configureTextField() {
        passwordTextField.delegate = self
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
    }
    
    private func isValid(password: String) -> Bool {
      if password.count < 6 || password.count > 20 {
        return false
      }

      let lowercaseCharacterSet = CharacterSet.lowercaseLetters
      if password.rangeOfCharacter(from: lowercaseCharacterSet) == nil {
        return false
      }

      let decimalDigitCharacterSet = CharacterSet.decimalDigits
      if password.rangeOfCharacter(from: decimalDigitCharacterSet) == nil {
        return false
      }

      let specialSymbolCharacterSet = CharacterSet(charactersIn: "!@#$")
      if password.rangeOfCharacter(from: specialSymbolCharacterSet) == nil {
        return false
      }

      return true
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
