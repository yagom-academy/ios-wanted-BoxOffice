//
//  CommentViewController.swift
//  BoxOffice
//
//  Created by 우롱차 on 2023/01/05.
//

import Foundation
import Combine
import UIKit

final class CommentViewController: UIViewController {
    
    private enum StarRate: Double {
        case zero = 0
        case one = 1
        case two = 2
        case three = 3
        case four = 4
        case five = 5
    }
    
    private enum Constant {
        static var emptyStar = UIImage(systemName: "star")
        static var halfStar = UIImage(systemName: "star.leadinghalf.filled")
        static var fullStar = UIImage(systemName: "star.fill")
        static var defalutImage = UIImage(systemName: "camera")
        static var starColor: UIColor = .systemYellow
        static var purple = UIColor(r: 76, g: 52, b: 145)
    }
    
    struct InputValue {
        let nickName: String?
        let password: String?
        let starRate: Double?
        let info: String?
        let image: UIImage?
    }
    
    private enum ConstantLayout {
        static var pictureInset: CGFloat = 30
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        setupConstraints()
        addGesture()
        bind()
    }
    
    init(viewModel: CommentAddViewModelInterface) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private var viewModel: CommentAddViewModelInterface
    private var cancelable = Set<AnyCancellable>()
    private var starRate: StarRate = .zero
    
    private lazy var baseScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        return scrollView
    }()
    
    private lazy var baseStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.layoutMargins = UIEdgeInsets(top: 5, left: 10, bottom: 5, right: 10)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.distribution = .fill
        stackView.alignment = .center
        stackView.axis = .vertical
        return stackView
    }()
    
    private lazy var pictureImageView: UIImageView = {
        let image = UIImageView()
        image.image = Constant.defalutImage
        image.tintColor = Constant.purple
        image.contentMode = .scaleAspectFit
        return image
    }()
    
    private lazy var nickNameTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "별명"
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.textAlignment = .center
        textField.layer.borderColor = Constant.purple.cgColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private lazy var passwordTextField: UITextField = {
        let textField = UITextField(frame: .zero)
        textField.placeholder = "암호"
        textField.textAlignment = .center
        textField.font = .preferredFont(forTextStyle: .title2)
        textField.isSecureTextEntry = true
        textField.layer.borderColor = Constant.purple.cgColor
        textField.layer.borderWidth = 2.0
        textField.layer.cornerRadius = 10
        return textField
    }()
    
    private lazy var starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private lazy var star1Image: UIImageView = {
        let imageView = UIImageView(image: Constant.emptyStar)
        imageView.tintColor = Constant.starColor
        return imageView
    }()
    
    private lazy var star2Image: UIImageView = {
        let imageView = UIImageView(image: Constant.emptyStar)
        imageView.tintColor = Constant.starColor
        return imageView
    }()
    
    private lazy var star3Image: UIImageView = {
        let imageView = UIImageView(image: Constant.emptyStar)
        imageView.tintColor = Constant.starColor
        return imageView
    }()
    
    private lazy var star4Image: UIImageView = {
        let imageView = UIImageView(image: Constant.emptyStar)
        imageView.tintColor = Constant.starColor
        return imageView
    }()
    
    private lazy var star5Image: UIImageView = {
        let imageView = UIImageView(image: Constant.emptyStar)
        imageView.tintColor = Constant.starColor
        return imageView
    }()
    
    private lazy var infoTextView: UITextView = {
        let textView = UITextView()
        textView.layer.borderColor = Constant.purple.cgColor
        textView.layer.borderWidth = 2.0
        textView.layer.cornerRadius = 10
        return textView
    }()
    
    private lazy var registerButton: UIButton = {
        let button = UIButton()
        button.addTarget(self, action: #selector(registerComment(_:)), for: .touchUpInside)
        button.setTitle("등록", for: .normal)
        button.setTitleColor(UIColor(r: 76, g: 52, b: 145), for: .normal)
        return button
    }()
    
    @objc func registerComment(_ sender: UIButton) {
        let image = pictureImageView.image == Constant.defalutImage ? nil : pictureImageView.image
        let input = InputValue(
            nickName: nickNameTextField.text,
            password: passwordTextField.text,
            starRate: self.starRate.rawValue,
            info: infoTextView.text,
            image: image
        )
        viewModel.input.registerComment(input: input)
    }
    
    @objc func addImage(_ sender: UITapGestureRecognizer) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .photoLibrary
        imagePicker.delegate = self
        present(imagePicker, animated: true)
    }
    
    @objc func changeStarRate(_ sender: UITapGestureRecognizer) {
        let location = sender.location(in: starStackView)
        let current = location.x
        let min = starStackView.frame.minX
        let max = starStackView.frame.maxX
        let rate = calculateStarRate(current: current, minX: min, maxX: max)
        changeRate(starRate: rate)
    }
}

private extension CommentViewController {
    
    private func calculateStarRate(current: CGFloat, minX: CGFloat, maxX: CGFloat) -> StarRate {
        let newCurrent = current
        let oneStarLenth = (maxX - minX) / 5
        let rate = newCurrent / oneStarLenth
        if rate > 4 { return StarRate.five}
        if rate > 3 { return StarRate.four}
        if rate > 2 { return StarRate.three}
        if rate > 1 { return StarRate.two}
        if rate >= 0.5 { return StarRate.one}
        return StarRate.zero
    }
    
    func addGesture() {
        pictureImageView.isUserInteractionEnabled = true
        pictureImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(addImage)))
        starStackView.isUserInteractionEnabled = true
        starStackView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(changeStarRate)))
    }
    
    func setup() {
        view.addSubviews(baseScrollView)
        baseScrollView.addSubviews(baseStackView)
        starStackView.addArrangedSubviews(
            star1Image,
            star2Image,
            star3Image,
            star4Image,
            star5Image
        )
        baseStackView.addArrangedSubviews(
            pictureImageView,
            starStackView,
            nickNameTextField,
            passwordTextField,
            infoTextView,
            registerButton
        )
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            baseScrollView.topAnchor.constraint(equalTo: view.topAnchor),
            baseScrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            baseScrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            baseScrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            baseScrollView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            baseStackView.topAnchor.constraint(equalTo: baseScrollView.topAnchor),
            baseStackView.leadingAnchor.constraint(equalTo: baseScrollView.leadingAnchor),
            baseStackView.trailingAnchor.constraint(equalTo: baseScrollView.trailingAnchor),
            baseStackView.widthAnchor.constraint(equalTo: view.widthAnchor)
        ])
        
        NSLayoutConstraint.activate([
            pictureImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
            pictureImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.8),
        ])
        
        NSLayoutConstraint.activate([
            nickNameTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
            passwordTextField.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
        ])
        
        NSLayoutConstraint.activate([
            infoTextView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.5),
            infoTextView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1.0),
        ])
        
        
        NSLayoutConstraint.activate([
            star1Image.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            star1Image.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            star2Image.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            star2Image.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            star3Image.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            star3Image.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            star4Image.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            star4Image.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            star5Image.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15),
            star5Image.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.15)
        ])
    }
    
    private func changeRate(starRate: StarRate) {
        self.starRate = starRate
        switch starRate {
        case .zero:
            star1Image.image = Constant.emptyStar
            star2Image.image = Constant.emptyStar
            star3Image.image = Constant.emptyStar
            star4Image.image = Constant.emptyStar
            star5Image.image = Constant.emptyStar
        case .one:
            star1Image.image = Constant.fullStar
            star2Image.image = Constant.emptyStar
            star3Image.image = Constant.emptyStar
            star4Image.image = Constant.emptyStar
            star5Image.image = Constant.emptyStar
        case .two:
            star1Image.image = Constant.fullStar
            star2Image.image = Constant.fullStar
            star3Image.image = Constant.emptyStar
            star4Image.image = Constant.emptyStar
            star5Image.image = Constant.emptyStar
        case .three:
            star1Image.image = Constant.fullStar
            star2Image.image = Constant.fullStar
            star3Image.image = Constant.fullStar
            star4Image.image = Constant.emptyStar
            star5Image.image = Constant.emptyStar
        case .four:
            star1Image.image = Constant.fullStar
            star2Image.image = Constant.fullStar
            star3Image.image = Constant.fullStar
            star4Image.image = Constant.fullStar
            star5Image.image = Constant.emptyStar
        case .five:
            star1Image.image = Constant.fullStar
            star2Image.image = Constant.fullStar
            star3Image.image = Constant.fullStar
            star4Image.image = Constant.fullStar
            star5Image.image = Constant.fullStar
        }
    }
    
    private func showErrorAlert(message: String) {
        let controller = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "확인", style: .cancel))
        present(controller, animated: true)
    }
    
    private func bind() {
        viewModel.output.errorPublisher.receive(on: DispatchQueue.main)
            .sink { [weak self] errorMessage in
                guard let self = self else { return }
                self.showErrorAlert(message: errorMessage)
            }
            .store(in: &cancelable)
        
        viewModel.output.uploadSuccessPublisher.receive(on: DispatchQueue.main)
            .sink { [weak self] isSucess in
                guard let self = self else { return }
                if isSucess {
                    self.dismiss(animated: true)
                }
            }.store(in: &cancelable)
    }
}

extension CommentViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            pictureImageView.contentMode = .scaleAspectFit
            pictureImageView.image = pickedImage
        }
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
