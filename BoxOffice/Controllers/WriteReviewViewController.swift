//
//  WriteReviewViewController.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/21.
//

import UIKit

class WriteReviewViewController: UIViewController {

  let starFilled = UIImage(systemName: "star.fill")
  let starEmpty = UIImage(systemName: "star")

  var starButtons = [UIButton]()

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
    tv.textContainerInset = UIEdgeInsets(top: 20, left: 10, bottom: -20, right: -10)
    tv.layer.borderWidth = 1
    tv.layer.borderColor = UIColor.gray.cgColor

    return tv
  }()

  let nickname: UITextField = {
    let tf = UITextField()
    tf.placeholder = "별명 입력"

    return tf
  }()

  let password: UITextField = {
    let tf = UITextField()
    tf.placeholder = "비밀번호 입력"

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
      horizontal.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 18),
      horizontal.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      reviewInput.topAnchor.constraint(equalTo: horizontal.bottomAnchor, constant: 18),
      reviewInput.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      reviewInput.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      vertical.topAnchor.constraint(equalTo: reviewInput.bottomAnchor, constant: 18),
      vertical.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
      vertical.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
      vertical.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -18),

    ])
  }

  @objc func starButtonTapped(_ sender: UIButton) {
    for i in 0 ... sender.tag {
      starButtons[i].setBackgroundImage(starFilled, for: .normal)
    }

    for i in sender.tag + 1 ..< 5 {
      starButtons[i].setBackgroundImage(starEmpty, for: .normal)
    }
  }

  @objc func doneButtonPressed() {
    print("리뷰 등록")
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
