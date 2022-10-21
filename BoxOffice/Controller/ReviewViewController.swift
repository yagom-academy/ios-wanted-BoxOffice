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
    var reviewWrite: (()->()) = {}
    
    init(movieName: String) {
        self.reviewViewModel.movieName = movieName
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
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
        let upload = reviewViewModel.sendData {
            let alert = UIAlertController(title: "업로드 완료", message: "", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .default, handler: {_ in
                self.reviewWrite()
                self.navigationController?.popViewController(animated: false)
            }))
            self.present(alert, animated: true)
        }
        
        if upload == 1 {
            let alert = UIAlertController(title: "업로드 실패", message: "별명,암호,리뷰는 필수 내용 입니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            present(alert, animated: true)
        } else if upload == 2{
            let alert = UIAlertController(title: "업로드 실패", message: "암호는 6~20자 소문자, 숫자, 특수문자(!,@,#,$) 각 1개 이상 포함 되어야 합니다", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "확인", style: .cancel))
            present(alert, animated: true)
        }
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
        if let imageUrl = info[UIImagePickerController.InfoKey.imageURL] as? URL{
            
            self.reviewViewModel.uploadImageURL = imageUrl
            
        }
    }
}
