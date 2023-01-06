//
//  MovieReviewViewController.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/05.
//

import UIKit

final class MovieReviewViewController: UIViewController {
    
    private let viewModel = MovieReviewViewModel()
    
    private let movieCode: String
    
    private let imagePicker: UIImagePickerController = {
        let imagePicker = UIImagePickerController()
        return imagePicker
    }()

    private let outerScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()

    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .large)
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()
    
    private let questionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "영화 어떠셨나요?"
        label.textColor = .label
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()

    private let starReviewWriteView: StarReviewWriteView = {
        let starReviewWriteView = StarReviewWriteView()
        starReviewWriteView.translatesAutoresizingMaskIntoConstraints = false
        return starReviewWriteView
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
            self.viewModel.cancelButtonTapped()
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
                rating: self.starReviewWriteView.rating,
                image: "",
                description: self.reviewTextView.text
            )
            self.viewModel.registrationButtonTapped(movieReview: movieReview)
        }), for: .touchUpInside)
        return button
    }()

    init(movieCode: String) {
        self.movieCode = movieCode
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
        
        addViews()
        setupLayout()
        configureImagePicker()
        configureTextField()
        bind()
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(_:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(_:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()

        nicknameTextField.setUnderLine(width: 1, color: .tertiaryLabel)
        passwordTextField.setUnderLine(width: 1, color: .tertiaryLabel)
    }
    
    @objc private func keyboardWillShow(_ notification: NSNotification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardHeight = keyboardFrame.cgRectValue.height
            outerScrollView.contentInset = .init(top: 0, left: 0, bottom: keyboardHeight, right: 0)
        }
    }
    
    @objc private func keyboardWillHide(_ notification: NSNotification) {
        outerScrollView.contentInset = .init(top: 0, left: 0, bottom: 0, right: 0)
    }
    
    private func bind() {
        viewModel.presentImagePicker = { [weak self] in
            self?.present(self!.imagePicker, animated: true)
        }
        viewModel.showAlert = { [weak self] alert in
            self?.present(alert, animated: true)
        }
        viewModel.popViewController = { [weak self] in
            self?.navigationController?.popViewController(animated: true)
        }
        viewModel.startLoadingIndicator = { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicator.startAnimating()
            }
        }
        viewModel.stopLoadingIndicator = { [weak self] in
            DispatchQueue.main.async {
                self?.loadingIndicator.stopAnimating()
            }
        }
        viewModel.enableRegisterButton = { [weak self] in
            self?.registrationButton.isEnabled = true
            self?.registrationButton.backgroundColor = .systemPurple
        }
        viewModel.disableRegisterButton = { [weak self] in
            self?.registrationButton.isEnabled = false
            self?.registrationButton.backgroundColor = .lightGray
        }
    }

    private func addViews() {
        view.addSubview(outerScrollView)
        view.addSubview(loadingIndicator)
        [
            questionLabel,
            starReviewWriteView,
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
            loadingIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loadingIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            outerScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            outerScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            outerScrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            outerScrollView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),

            questionLabel.topAnchor.constraint(equalTo: outerScrollView.topAnchor, constant: 80),
            questionLabel.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            
            starReviewWriteView.topAnchor.constraint(equalTo: questionLabel.bottomAnchor, constant: 16),
            starReviewWriteView.leadingAnchor.constraint(equalTo: questionLabel.leadingAnchor),
            
            reviewRequestLabel.topAnchor.constraint(equalTo: starReviewWriteView.bottomAnchor, constant: 50),
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
        guard var stringBeforeCurrentInput = textField.text else {
            return false
        }

        if string.isEmpty {
            _ = stringBeforeCurrentInput.popLast()
        }

        let passwordInput = stringBeforeCurrentInput + string
        
        if viewModel.isValid(password: passwordInput) {
            passwordRuleLabel.isHidden = true
        } else {
            passwordRuleLabel.isHidden = false
            passwordRuleLabel.textColor = .red
        }
        
        return true
    }
    
    private func configureTextField() {
        passwordTextField.delegate = self
        
        passwordTextField.isSecureTextEntry = true
        passwordTextField.textContentType = .password
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
