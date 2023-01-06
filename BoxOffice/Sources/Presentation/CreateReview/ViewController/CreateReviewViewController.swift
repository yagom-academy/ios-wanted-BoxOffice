//
//  CreateReviewViewController.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/04.
//

import UIKit

class CreateReviewViewController: UIViewController {

    weak var coordinator: CreateReviewCoordinatorInterface?
    private let viewModel: CreateReviewViewModel
    
    private let reviewPlaceHolder = "감상평을 자유롭게 작성해주세요."
    
    private lazy var cancelButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let config = UIImage.SymbolConfiguration(textStyle: .callout, scale: .large)
        button.setImage(UIImage(systemName: "xmark")?.withConfiguration(config), for: .normal)
        button.addTarget(self, action: #selector(didTapCancelButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.addSubviews(backgroundStackView)
        scrollView.keyboardDismissMode = .onDrag
        return scrollView
    }()
    
    private lazy var backgroundStackView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, alignment: .center, distribution: .fill, spacing: 25)
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
        stackView.addArrangedSubviews(createImageButton, textFieldsView, reviewInputTextView, ratingView, crateButton)
        return stackView
    }()
    
    
    private lazy var createImageButton: ProfileImageButton = {
        let button = ProfileImageButton(size: 125)
        button.addTarget(self, action: #selector(didTapProfileButton(_:)), for: .touchUpInside)
        return button
    }()
    
    private lazy var ratingView: RatingView = {
        let view = RatingView(
            config: UIImage.SymbolConfiguration(font: .preferredFont(forTextStyle: .largeTitle), scale: .large)
        )
        view.addTarget(target: self, action: #selector(didTapStarButton(_:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var textFieldsView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, alignment: .center, distribution: .fill, spacing: 8)
        stackView.addArrangedSubviews(nickNameInputView, passwordInputView)
        return stackView
    }()
    
    private lazy var nickNameInputView: BoxOfficeInputView = {
        let inputView = BoxOfficeInputView(title: "별명", placeholder: "별명을 입력해주세요.")
        inputView.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width - 60).isActive = true
        inputView.addTarget(target: self, action: #selector(didChangeNameTextField(_:)), for: [.allEditingEvents, .valueChanged])
        return inputView
    }()
    
    private lazy var passwordInputView: BoxOfficeInputView = {
        let inputView = BoxOfficeInputView(title: "암호", placeholder: "비밀번호를 입력해주세요.")
        inputView.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width - 60).isActive = true
        inputView.addTarget(target: self, action: #selector(didChangePasswordTextField(_:)), for: [.allEditingEvents, .valueChanged])
        return inputView
    }()
    
    private lazy var reviewInputTextView: UITextView = {
        let textView = UITextView()
        textView.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width - 60).isActive = true
        textView.heightAnchor.constraint(equalToConstant: 250).isActive = true
        textView.backgroundColor = .white.withAlphaComponent(0.8)
        textView.clipsToBounds = true
        textView.layer.cornerRadius = 12
        textView.layer.borderColor = UIColor.systemGray.cgColor
        textView.layer.borderWidth = 1
        textView.font = .preferredFont(forTextStyle: .subheadline)
        textView.textColor = .darkGray
        textView.tintColor = .black
        textView.text = reviewPlaceHolder
        textView.delegate = self
        return textView
    }()
    
    private lazy var crateButton: UIButton = {
        let button = UIButton()
        button.tintColor = .label
        let config = UIImage.SymbolConfiguration(textStyle: .callout, scale: .large)
        button.setTitle("리뷰 등록하기", for: .normal)
        button.backgroundColor = .systemIndigo
        button.clipsToBounds = true
        button.layer.cornerRadius = 12
        button.widthAnchor.constraint(equalToConstant: view.safeAreaLayoutGuide.layoutFrame.width - 60).isActive = true
        button.heightAnchor.constraint(equalToConstant: 44).isActive = true
        button.titleLabel?.font = .preferredFont(for: .body, weight: .semibold)
        button.addTarget(self, action: #selector(didTapCreateButton(_:)), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUp()
    }

    init(viewModel: CreateReviewViewModel, coordinator: CreateReviewCoordinatorInterface) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension CreateReviewViewController {
    
    func setUp() {
        setUpNavigationBar()
        setUpView()
    }
    
    func setUpNavigationBar() {
        navigationItem.title = "리뷰쓰기"
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: cancelButton)
    }
    
    func setUpView() {
        view.backgroundColor = .boBackground
        view.addSubviews(scrollView)
        let height = backgroundStackView.heightAnchor.constraint(equalTo: scrollView.heightAnchor)
        height.priority = .defaultLow
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            backgroundStackView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            backgroundStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            backgroundStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            backgroundStackView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            backgroundStackView.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            height
        ])
    }
    
    @objc func didTapCancelButton(_ sender: UIButton) {
        dismiss(animated: true) { [weak self] in
            self?.coordinator?.finish()
        }
    }
    
    @objc func didTapProfileButton(_ sender: ProfileImageButton) {
        coordinator?.showImagePicker(self)
    }
    
    @objc func didTapCreateButton(_ sender: UIButton) {
        viewModel.input.didTapCreateButton()
    }
    
    @objc func didChangeNameTextField(_ sender: UITextField) {
        viewModel.input.nameText(sender.text ?? "")
    }
    
    @objc func didChangePasswordTextField(_ sender: UITextField) {
        viewModel.input.passwordText(sender.text ?? "")
    }
    
    @objc func didTapStarButton(_ sender: StarButton) {
        let state = sender.currentState
        if state == .noon {
            sender.changeState(.filled)
        } else if state == .leadinghalf {
            sender.changeState(.noon)
        } else {
            sender.changeState(.leadinghalf)
        }
        viewModel.input.didTapRatingView(sender.tag + 1)
    }
    
}

extension CreateReviewViewController: UITextViewDelegate {
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == reviewPlaceHolder {
            textView.text = nil
            textView.textColor = .black
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel.input.reviewText(textView.text)
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            textView.text = reviewPlaceHolder
            textView.textColor = .darkGray
        }
    }
    
}

extension CreateReviewViewController: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage
        let editedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage
        guard let selectedImage = editedImage ?? originalImage else {
            return
        }
        createImageButton.setImage(selectedImage.withConfiguration(createImageButton.config), for: .normal)
        viewModel.input.imageData(selectedImage.toString ?? "")
        picker.dismiss(animated: true)
    }
    
}
