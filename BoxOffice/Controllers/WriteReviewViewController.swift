//
//  WriteReviewViewController.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/21.
//

import UIKit

protocol WriteReviewDelegate {
  func addReview(review: ReviewModel, fileName: String)
}

class WriteReviewViewController: UIViewController {

  var delegate: WriteReviewDelegate?

  let starFilled = UIImage(systemName: "star.fill")
  let starEmpty = UIImage(systemName: "star")

  var starButtons = [UIButton]()
  var score = 0
  var movieCode = ""

  let horizontal: UIStackView = {
    let sv = UIStackView()
    sv.axis = .horizontal
    sv.distribution = .fill
    sv.alignment = .fill
    sv.spacing = 8

    return sv
  }()

  let reviewInput: UITextView = {
    let tv = UITextView()
    tv.textContainerInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    tv.layer.borderWidth = 1
    tv.layer.borderColor = UIColor.gray.cgColor
    tv.autocapitalizationType = .none

    return tv
  }()

  let nickname: UITextField = {
    let tf = UITextField()
    tf.placeholder = "별명 입력"
    tf.autocapitalizationType = .none

    return tf
  }()

  let password: UITextField = {
    let tf = UITextField()
    tf.placeholder = "비밀번호 입력"
    tf.autocapitalizationType = .none
//    tf.isSecureTextEntry = true

    return tf
  }()

  let vertical: UIStackView = {
    let sv = UIStackView()
    sv.axis = .vertical
    sv.distribution = .fill
    sv.spacing = 8

    return sv
  }()

  override func viewDidLoad() {
    super.viewDidLoad()

    view.backgroundColor = .white
    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done,
                                                        target: self,
                                                        action: #selector(doneButtonPressed))
    navigationController?.navigationBar.tintColor = .black

    addViews()
    setConstraints()
    setActions()
  }

}

extension WriteReviewViewController {
  func addViews() {
    for i in 0 ..< 5 {
      let button = UIButton()
      button.setBackgroundImage(starEmpty, for: .normal)
      button.tintColor = .systemYellow
      button.tag = i
      button.addTarget(self, action: #selector(starButtonTapped), for: .touchUpInside)
      starButtons.append(button)
      horizontal.addArrangedSubview(button)
    }

    [nickname, password, ].forEach {
      vertical.addArrangedSubview($0)
    }

    [horizontal, reviewInput, vertical, ].forEach {
      view.addSubview($0)
    }
  }

  func setConstraints() {
    [horizontal, reviewInput, vertical, ].forEach {
      $0.translatesAutoresizingMaskIntoConstraints = false
    }

    NSLayoutConstraint.activate([
      horizontal.topAnchor.constraint(lessThanOrEqualTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
      horizontal.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      vertical.topAnchor.constraint(equalTo: horizontal.bottomAnchor, constant: 18),
      vertical.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      vertical.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      reviewInput.topAnchor.constraint(equalTo: vertical.bottomAnchor, constant: 18),
      reviewInput.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 20),
      reviewInput.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
      reviewInput.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),

    ])
  }

  func setActions() {
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)

    view.addGestureRecognizer(UITapGestureRecognizer(target: self,
                                                     action: #selector(dismissKeyboard)))
  }

  func checkValidPassword(_ pw: String) -> Bool {
    let pattern = #"^(?=.*[a-z])(?=.*\d)(?=.*[!@#$])[a-z0-9!@#$]{6,20}$"#

    if pw.range(of: pattern, options: .regularExpression) != nil {
      return true
    } else { return false }
  }

  @objc func starButtonTapped(_ sender: UIButton) {
    score = sender.tag + 1

    for i in 0 ... sender.tag {
      starButtons[i].setBackgroundImage(starFilled, for: .normal)
    }

    for i in sender.tag + 1 ..< 5 {
      starButtons[i].setBackgroundImage(starEmpty, for: .normal)
    }
  }

  @objc func doneButtonPressed() {
    print("리뷰 등록")
    if nickname.text! == "" || !checkValidPassword(password.text!) {
      let alertController = UIAlertController(title: "별명 또는 비밀번호 형식 오류",
                                              message: """
                                              별명 한 글자 이상, 비밀번호 6 ~ 20자리
                                              알파벳 소문자, 숫자, 특수문자[!, @, #, $] 각 한 글자 이상 포함
                                              """,
                                              preferredStyle: .alert)
      let confirmAction = UIAlertAction(title: "확인", style: .default, handler: { _ in
        print(self.nickname.text!, self.password.text!)
      })
      alertController.addAction(confirmAction)
      present(alertController, animated: true, completion: nil)
    } else {
      print(movieCode, nickname.text!, password.text!, score, reviewInput.text!)

      let reviewInfo = ReviewModel(movieCode: movieCode,
                               nickname: nickname.text!,
                               password: password.text!,
                               review: reviewInput.text!, score: score)
      let fileName = UUID().uuidString

      delegate?.addReview(review: reviewInfo, fileName: fileName)
      FireStorageManager.shared.uploadReview(movieCode: movieCode,
                                             fileName: fileName,
                                             reviewInfo: reviewInfo)
      self.navigationController?.popViewController(animated: true)
    }

  }

  // TODO: - 가로 모드에서 화면 올리기, verticalScrollInset 수정하기
  @objc func keyboardWillShow(_ notification: NSNotification) {
    guard let userInfo = notification.userInfo,
          let keyboardFrame = userInfo[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue
//          let currentTextView = UIResponder.currentFirst() as? UITextView
    else { return }

//    let keyboardTopY = keyboardFrame.cgRectValue.origin.y
//    let convertedTextViewFrame = view.convert(currentTextView.frame, from: currentTextView.superview)
//    let textViewMidY = convertedTextViewFrame.origin.y + convertedTextViewFrame.size.height / 2

    self.reviewInput.contentInset.bottom = keyboardFrame.cgRectValue.size.height
    self.reviewInput.verticalScrollIndicatorInsets.bottom = keyboardFrame.cgRectValue.size.height / 2
  }

  @objc func keyboardWillHide(_ notification: NSNotification) {
    self.view.frame.origin.y = 0
    self.reviewInput.textContainerInset = UIEdgeInsets(top: 20, left: 10, bottom: 20, right: 10)
    self.reviewInput.verticalScrollIndicatorInsets = UIEdgeInsets.zero
  }

  @objc func dismissKeyboard() {
    view.endEditing(true)
  }
}

#if canImport(SwiftUI) && DEBUG
import SwiftUI
struct WriteReviewVC_Preview: PreviewProvider {
  static var previews: some View {
    WriteReviewViewController().showPreview()
  }
}
#endif
