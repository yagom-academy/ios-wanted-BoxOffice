//
//  ReviewViewController.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/20.
//

import UIKit

class ReviewViewController: UIViewController {
    
    let mainView = ReviewView()
    let reviewViewModel = ReviewViewModel()
    
    override func loadView() {
        self.view = mainView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidLayoutSubviews() {
        mainView.nicknameTextField.setUnderLine()
        mainView.passwordTextField.setUnderLine()
    }
    
    func setup() {
        mainView.nicknameTextField.delegate = self
        mainView.passwordTextField.delegate = self
        mainView.reviewTextView.delegate = self
        mainView.reviewButton.addTarget(self, action: #selector(writeReview), for: .touchUpInside)
        mainView.starScore.buttonAction = { score in
            self.reviewViewModel.score = score
        }
        mainView.uploadImageButton.addTarget(self, action: #selector(uploadImageButtonClicked), for: .touchUpInside)
    }
    
    @objc func writeReview() {
        reviewViewModel.sendData()
    }
    
    
}

extension ReviewViewController: UITextFieldDelegate {
    
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.tag == 0 {
            reviewViewModel.nickname = textField.text ?? ""
        } else {
            reviewViewModel.password = textField.text ?? ""
        }
    }
}

extension ReviewViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        reviewViewModel.text = textView.text ?? ""
    }
}

extension ReviewViewController: UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @objc func uploadImageButtonClicked() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        self.present(imagePicker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            self.mainView.uploadImageButton.setImage(image, for: .normal)
            self.mainView.uploadImageButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
            dismiss(animated: true, completion: nil)
        }
    }
}
