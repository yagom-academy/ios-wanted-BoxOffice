//
//  LoginViewController.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/06.
//

import UIKit

class LoginViewController: UIViewController {
    // MARK: Properties
    private let loginView = LoginView()
    private var movieName = ""

    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()

        configureView()
        configureUI()
        
        registerButtonAction()
    }
    
    // MARK: private function
    private func configureView() {
        view.addSubview(loginView)
        view.backgroundColor = .white
        
        self.title = "리뷰 작성"
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            title: "저장",
            style: .done,
            target: self,
            action: #selector(verifyPassword)
        )
    }
    
    // MARK: private function
    private func configureUI() {
        NSLayoutConstraint.activate([
            loginView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            loginView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            loginView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            loginView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func registerButtonAction() {
        loginView.userImageButton.addTarget(
            self,
            action: #selector(selectImage),
            for: .touchUpInside
        )
        
        loginView.twoStarButton.addTarget(
            self,
            action: #selector(didTapTwoStarButton),
            for: .touchUpInside
        )
        
        loginView.threeStarButton.addTarget(
            self,
            action: #selector(didTapThreeStarButton),
            for: .touchUpInside
        )
        
        loginView.fourStarButton.addTarget(
            self,
            action: #selector(didTapFourStarButton),
            for: .touchUpInside
        )
        
        loginView.fiveStarButton.addTarget(
            self,
            action: #selector(didTapFiveStarButton),
            for: .touchUpInside
        )
    }
    
    private func showFailureAlert() {
        let alert = UIAlertController(
            title: "리뷰 작성 실패",
            message: "암호는 6자리 이상, 20자리 이하, \n 반드시 알파벳 소문자, 아라비아 숫자, 특수문자만 각 1개 이상 포함되어야 합니다.",
            preferredStyle: UIAlertController.Style.alert
        )
        
        let okAction = UIAlertAction(title: "확인", style: .default)
        alert.addAction(okAction)
        
        present(alert, animated: false, completion: nil)
    }
    
    private func showSuccessAlert() {
        let alert = UIAlertController(
            title: "리뷰 작성 성공",
            message: "리뷰가 성공적으로 저장되었습니다.🥳",
            preferredStyle: UIAlertController.Style.alert
        )
        
        let okAction = UIAlertAction(title: "확인", style: .default, handler: { [weak self] _ in
            self?.navigationController?.popViewController(animated: true)
        })
        alert.addAction(okAction)
    
        present(alert, animated: false, completion: nil)
    }
    
    private func saveFireStore() {
        let image = loginView.userImageButton.imageView?.image?.toBase64 ?? ""

        print("🥳\(image)")
        
        let model = LoginModel(
            image: image,
            nickname: loginView.nickNameTextView.text,
            password: loginView.passwordTextView.text,
            star: getStar(),
            content: loginView.contentTextView.text)
        FirebaseManager.shared.save(
            model,
            movieName: movieName
        )
    }
    
    private func getStar() -> Int {
        var result = 1
        if loginView.twoStarButton.currentImage == UIImage(systemName: "star.fill") {
            result += 1
        }
        
        if loginView.threeStarButton.currentImage == UIImage(systemName: "star.fill") {
            result += 1
        }
        
        if loginView.fourStarButton.currentImage == UIImage(systemName: "star.fill") {
            result += 1
        }
        
        if loginView.fiveStarButton.currentImage == UIImage(systemName: "star.fill") {
            result += 1
        }
        
        return result
    }
    
    private func clearAllStarScore() {
        loginView.twoStarButton.setImage(UIImage(systemName: "star"), for: .normal)
        loginView.threeStarButton.setImage(UIImage(systemName: "star"), for: .normal)
        loginView.fourStarButton.setImage(UIImage(systemName: "star"), for: .normal)
        loginView.fiveStarButton.setImage(UIImage(systemName: "star"), for: .normal)
    }
    
    private func fillAllStarScore() {
        loginView.twoStarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        loginView.threeStarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        loginView.fourStarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        loginView.fiveStarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
    }
    
    // MARK: objc function
    @objc private func selectImage() {
        let imagePickerController = UIImagePickerController()
        
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @objc private func verifyPassword() {
        guard let password = loginView.passwordTextView.text else {
            showFailureAlert()
            return
        }
        
        if (password.count < 6) || (password.count > 20) {
            showFailureAlert()
            return
        }
        
        let temp = password.filter {
            (!$0.isLowercase) && (!$0.isNumber) && (!["!", "@", "#", "$"].contains(String($0)))
        }
        
        if temp.count > 0 {
            showFailureAlert()
            return
        }
        
        
        let alpha = password.filter {
            $0.isLowercase
        }
        let number = password.filter {
            $0.isNumber
        }
        let symbol = password.filter {
            ["!", "@", "#", "$"].contains(String($0))
        }
        
        if (alpha.count < 1) || (number.count < 1) || (symbol.count < 1) {
            showFailureAlert()
            return
        }
        
        saveFireStore()
        showSuccessAlert()
    }
    
    @objc private func didTapTwoStarButton() {
        guard let currentImage = loginView.twoStarButton.currentImage else {
            return
        }
        
        if currentImage == UIImage(systemName: "star") {
            loginView.twoStarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            clearAllStarScore()
        }
    }
    
    @objc private func didTapThreeStarButton() {
        guard let currentImage = loginView.threeStarButton.currentImage else {
            return
        }
        
        if currentImage == UIImage(systemName: "star") {
            loginView.twoStarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
            loginView.threeStarButton.setImage(UIImage(systemName: "star.fill"), for: .normal)
        } else {
            clearAllStarScore()
            didTapTwoStarButton()
        }
       
    }
    
    @objc private func didTapFourStarButton() {
        guard let currentImage = loginView.fourStarButton.currentImage else {
            return
        }
        
        if currentImage == UIImage(systemName: "star") {
            fillAllStarScore()
            loginView.fiveStarButton.setImage(UIImage(systemName: "star"), for: .normal)
        } else {
            clearAllStarScore()
            didTapThreeStarButton()
        }
        
    }
    
    @objc private func didTapFiveStarButton() {
        guard let currentImage = loginView.fiveStarButton.currentImage else {
            return
        }
        
        if currentImage == UIImage(systemName: "star") {
            fillAllStarScore()
        } else {
            fillAllStarScore()
            loginView.fiveStarButton.setImage(UIImage(systemName: "star"), for: .normal)
        }
    }
}

// MARK: Extension - SendDataDelegate
extension LoginViewController: SendDataDelegate {
    func sendData<T>(_ data: T) {
        guard let name = data as? String else {
            return
        }
        
        movieName = name
    }
}

// MARK: Extension - UIImagePickerControllerDelegate, UINavigationControllerDelegate
extension LoginViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(
        _ picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]
    ) {
        if var image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            image = image.resize(newWidth: 100)
            loginView.userImageButton.setImage(image, for: .normal)
        }

        picker.dismiss(animated: true, completion: nil)
    }
}
