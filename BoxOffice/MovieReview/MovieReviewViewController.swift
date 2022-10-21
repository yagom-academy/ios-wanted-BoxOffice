//
//  MovieReviewViewController.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/20.
//

import UIKit
import FirebaseStorage

final class MovieReviewViewController: UIViewController {
    
    private let contentTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = "내용"
        return label
    }()
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.contentInset = .init(top: 10, left: 10, bottom: 10, right: 10)
        textView.font = .systemFont(ofSize: 12, weight: .regular)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor.systemGray5.cgColor
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    private let starTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 15, weight: .semibold)
        label.text = "별점"
        return label
    }()
    
    private let starPickerView: UIPickerView = {
        let picker = UIPickerView()
        return picker
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.alignment = .leading
        return stackView
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.text = "암호는 알파벳 소문자, 숫자, 특수문자가 1개 이상, 6~20자로 작성해주세요."
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .red
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.layer.borderWidth = 3
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.cornerRadius = 10
        button.setTitle("리뷰 등록", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.isEnabled = false
        return button
    }()
    
    var movieTitle: String = ""
    private var viewModel: MovieReviewViewModel = .init()
    private var finalReview: ReviewModel = .init(nickname: "", password: "", starScore: 0, content: "") {
        didSet {
            print("리뷰 변경", finalReview)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupLayouts()
        self.starPickerView.dataSource = self
        self.starPickerView.delegate = self
        self.contentTextView.delegate = self
        self.registerButton.addTarget(self, action: #selector(registerButtonTapped(_:)), for: .touchUpInside)
        print("title: \(movieTitle)")
    }
    
    private func bind(_ viewmodel: MovieReviewViewModel) {
        let output = viewModel.transform()
        output.buttonIsEnable.subscribe { [weak self] isEnabled in
            let buttonColor: UIColor = isEnabled ? .systemBlue : .white
            let titleColor: UIColor = isEnabled ? .white : .black
            self?.registerButton.backgroundColor = buttonColor
            self?.registerButton.setTitleColor(titleColor, for: .normal)
            self?.registerButton.isEnabled = isEnabled
            print("유효성 \(isEnabled)")
        }
        
        output.passwordIsValid.subscribe { [weak self] isValid in
            print("비번: \(isValid)")
            self?.errorLabel.isHidden = isValid
        }
        
        output.registerReview.subscribe { model in
            self.finalReview = model
        }
        
    }
    
    private func uploadReviewToStorage(_ review: ReviewModel) {
        let reviewName = "[영화리뷰] : " + movieTitle
        let jsonEncoder = JSONEncoder()
        jsonEncoder.outputFormatting = .prettyPrinted
        do {
            let data = try jsonEncoder.encode(review)
            let storageRef = Storage.storage().reference().child("\(reviewName)")
            let metaData = StorageMetadata()
            metaData.contentType = "txt"
            storageRef.putData(data, metadata: metaData) { metaData, error in
                if let error = error {
                    print("metadata error: \(error)")
                } else {
                    print("🎉 Upload Success")
                }
            }
        } catch {
            fatalError("🚨ERROR: Review encode fail")
        }
        
    }
    
    @objc func registerButtonTapped(_ sender: UIButton) {
        self.uploadReviewToStorage(finalReview)
        let alertVC = UIAlertController(title: nil, message: "🎉 \(movieTitle) \n 영화 리뷰가 작성되었습니다!", preferredStyle: .alert)
        let confirm = UIAlertAction(title: "확인", style: .default) { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        }
        alertVC.addAction(confirm)
        self.present(alertVC, animated: true)
    }
    
    private func setupLayouts() {
        ["별명", "암호"].forEach {
            let reviewView = ReviewTextView(title: $0)
            if $0 == "암호" {
                reviewView.textField.isSecureTextEntry = true
            }
            reviewView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
            reviewView.delegate = self
            self.infoStackView.addArrangedSubview(reviewView)
        }
        
        self.view.addSubViewsAndtranslatesFalse(self.infoStackView,
                                                self.starTitleLabel,
                                                self.starPickerView,
                                                self.contentTitleLabel,
                                                self.contentTextView,
                                                self.errorLabel,
                                                self.registerButton)
        
        NSLayoutConstraint.activate([
            self.infoStackView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor, constant: 20),
            self.infoStackView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor, constant: 30),
            self.infoStackView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor, constant: -30)])
        
        NSLayoutConstraint.activate([
            self.starTitleLabel.topAnchor.constraint(equalTo: self.infoStackView.bottomAnchor, constant: 10),
            self.starTitleLabel.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor),
            self.starPickerView.topAnchor.constraint(equalTo: self.starTitleLabel.bottomAnchor, constant: 10),
            self.starPickerView.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor),
            self.starPickerView.topAnchor.constraint(equalTo: self.starTitleLabel.bottomAnchor, constant: 10),
            self.starPickerView.heightAnchor.constraint(equalToConstant: 100)])
        
        NSLayoutConstraint.activate([
            self.contentTitleLabel.topAnchor.constraint(equalTo: self.starPickerView.bottomAnchor, constant: 10),
            self.contentTitleLabel.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor),
            
            self.contentTextView.topAnchor.constraint(equalTo: self.contentTitleLabel.bottomAnchor, constant: 10),
            self.contentTextView.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor),
            self.contentTextView.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor),
            self.contentTextView.heightAnchor.constraint(equalToConstant: 200)
        ])
        
        NSLayoutConstraint.activate([
            self.errorLabel.topAnchor.constraint(equalTo: self.contentTextView.bottomAnchor, constant: 20),
            self.errorLabel.leadingAnchor.constraint(equalTo: self.infoStackView.leadingAnchor),
            self.errorLabel.trailingAnchor.constraint(equalTo: self.infoStackView.trailingAnchor),
            self.errorLabel.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.registerButton.topAnchor.constraint(equalTo: self.errorLabel.bottomAnchor, constant: 30),
            self.registerButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.registerButton.widthAnchor.constraint(equalToConstant: 150),
            self.registerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
}
// MARK: - extension
extension MovieReviewViewController: ReviewTextViewDelegate {
    func textFieldEditEnd(title: String, text: String) {
        switch title {
        case "별명":
            viewModel.nickname.value = text
        case "암호":
            viewModel.password.value = text
        default:
            return
        }
        bind(viewModel)
    }
}

extension MovieReviewViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        viewModel.content.value = textView.text
        bind(viewModel)
    }
}

extension MovieReviewViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return viewModel.starValueList.count
    }
}

extension MovieReviewViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return viewModel.starValueList[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        viewModel.starScore.value =  viewModel.starValueList[row]
        bind(viewModel)
    }
}
