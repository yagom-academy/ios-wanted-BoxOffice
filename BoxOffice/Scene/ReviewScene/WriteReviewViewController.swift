//
//  WriteReviewViewController.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/03.
//

import UIKit

class WriteReviewViewController: UIViewController {
    private let photoButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "photo.on.rectangle.angled"), for: .normal)
        button.tintColor = .black
        button.backgroundColor = .systemGray6
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let nickNameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임을 입력해주세요."
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "암호를 입력해주세요."
        textField.borderStyle = .roundedRect
        textField.font = .preferredFont(forTextStyle: .title3)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.borderWidth = 2
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
    }()
    
    private let textFieldStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let photoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 16
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let reviewViewModel = MovieReviewViewModel()
    private let ratingStarView = StarRatingView()
    private let imagePicker = UIImagePickerController()
    private var password = String()
    private var imageURL = String()
    private let movie: MovieData
    
    init(movie: MovieData) {
        self.movie = movie
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupDelegate()
        bind()
    }
    
    private func setupDelegate() {
        setupTextFieldDelegate()
        setupImagePicker()
    }
    
    private func setupView() {
        addSubView()
        setupConstraint()
        setupNavigationItem()
        view.backgroundColor = .systemBackground
    }
    
    private func addSubView() {
        textFieldStackView.addArrangedSubview(nickNameTextField)
        textFieldStackView.addArrangedSubview(passwordTextField)
        
        photoStackView.addArrangedSubview(photoButton)
        photoStackView.addArrangedSubview(textFieldStackView)
        
        entireStackView.addArrangedSubview(ratingStarView)
        entireStackView.addArrangedSubview(photoStackView)
        entireStackView.addArrangedSubview(contentTextView)
        
        view.addSubview(entireStackView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            entireStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor,
                                                 constant: 8),
            entireStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor,
                                                 constant: -8),
            entireStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor,
                                                 constant: 16),
            entireStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor,
                                                 constant: -16),
            
            photoButton.widthAnchor.constraint(equalTo: photoButton.heightAnchor),
            photoButton.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor,
                                                multiplier: 1/8)
        ])
    }
    
    private func bind() {
        reviewViewModel.error
            .bind { error in
                //TODO: 저장 실패 얼럿
            }
    }
}

//MARK: NavigationItem Setting
extension WriteReviewViewController {
    private func setupNavigationItem() {
        let saveBarButton = UIBarButtonItem(title: "저장",
                                            style: .done,
                                            target: self,
                                            action: #selector(saveBarButtonTapped))
        
        navigationItem.rightBarButtonItem = saveBarButton
        navigationItem.title = movie.title
    }
    
    @objc private func saveBarButtonTapped() {
        guard let newReview = createReview() else { return }
        let movieKey = movie.title + movie.openYear
        
        reviewViewModel.save(newReview, at: movieKey)
        navigationController?.popViewController(animated: true)
    }
    
    private func createReview() -> Review? {
        guard let nickName = nickNameTextField.text,
              let rating = ratingStarView.rating,
              let content = contentTextView.text else { return nil }
        
        guard nickName.isEmpty == false,
              content.isEmpty == false,
              password.isEmpty == false else {
            //TODO: 모든 항목 입력 확인 얼럿 띄우기
            return nil
        }
        
        if validatePassword() == false {
            //TODO: 암호 유효성 실패 얼럿 띄우기
            return nil
        }
        
        return Review(nickName: nickName,
                      password: password,
                      rating: rating,
                      content: content,
                      imageURL: imageURL)
    }
}

extension WriteReviewViewController: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    private func setupImagePicker() {
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        
        photoButton.addTarget(self,
                              action: #selector(photoButtonTapped),
                              for: .touchUpInside)
    }
    
    @objc private func photoButtonTapped() {
        present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var selectedImage: UIImage? = nil
        
        if let image = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            selectedImage = image
        } else if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            selectedImage = image
        }
              
        photoButton.setImage(selectedImage, for: .normal)
        self.dismiss(animated: true, completion: nil)
    }
}

//MARK: Password Process
extension WriteReviewViewController: UITextFieldDelegate {
    private func setupTextFieldDelegate() {
        passwordTextField.delegate = self
    }
    
    private func validatePassword() -> Bool {
        let number = convertToSet("0123456789")
        let specialCharacters = convertToSet("!@#$")
        let alphabet = convertToSet("abcdefghijklmnopqrstuvwxyz")
        let checkingPassword = convertToSet(password)
        
        guard (6...20).contains(password.count),
              checkingPassword.intersection(number).isEmpty == false,
              checkingPassword.intersection(specialCharacters).isEmpty == false,
              checkingPassword.intersection(alphabet).isEmpty == false else {
            return false
        }
        
        return true
    }
    
    private func convertToSet(_ text: String) -> Set<String> {
        var newSet: Set<String> = []
        
        text.forEach {
            newSet.update(with: String($0))
        }
        
        return newSet
    }
    
    private func hidePasswordText(with textField: UITextField) {
        if let text = textField.text {
            textField.text = String(repeating: "*", count: text.count)
        }
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        hidePasswordText(with: textField)
    }
    
    func textField(_ textField: UITextField,
                   shouldChangeCharactersIn range: NSRange,
                   replacementString string: String) -> Bool {
        if range.length > 0 {
            (1...range.length).forEach { _ in
                _ = password.popLast()
            }
            return true
        }
        
        hidePasswordText(with: textField)
        password += string
        return true
    }
}
