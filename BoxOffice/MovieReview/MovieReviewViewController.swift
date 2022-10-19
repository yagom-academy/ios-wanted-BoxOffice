//
//  MovieReviewViewController.swift
//  BoxOffice
//
//  Created by Julia on 2022/10/20.
//

import UIKit

final class MovieReviewViewController: UIViewController {
    
    private let contentTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .semibold)
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
        label.font = .systemFont(ofSize: 14, weight: .semibold)
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
    
    private let registerButton: UIButton = {
        let button = UIButton()
        button.setTitle("리뷰 등록", for: .normal)
        button.backgroundColor = .systemBlue
        button.layer.cornerRadius = 10
        return button
    }()
    
    private let starValueList = ["1","2","3","4","5"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        self.setupLayouts()
        self.starPickerView.dataSource = self
        self.starPickerView.delegate = self
    }
    
    private func setupLayouts() {
        ["별명", "암호"].forEach {
            let reviewView = ReviewTextView(title: $0)
            if $0 == "암호" {
                reviewView.textField.isSecureTextEntry = true
            }
            reviewView.widthAnchor.constraint(equalToConstant: self.view.bounds.width).isActive = true
            self.infoStackView.addArrangedSubview(reviewView)
        }
        
        self.view.addSubViewsAndtranslatesFalse(self.infoStackView,
                                                self.starTitleLabel,
                                                self.starPickerView,
                                                self.contentTitleLabel,
                                                self.contentTextView,
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
            self.registerButton.topAnchor.constraint(equalTo: self.contentTextView.bottomAnchor, constant: 30),
            self.registerButton.centerXAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.centerXAnchor),
            self.registerButton.widthAnchor.constraint(equalToConstant: 150),
            self.registerButton.heightAnchor.constraint(equalToConstant: 40)
        ])
        
    }
    
}

extension MovieReviewViewController: UIPickerViewDataSource {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return starValueList.count
    }
}

extension MovieReviewViewController: UIPickerViewDelegate {
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return starValueList[row]
    }
    
    //    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
    //        <#code#>
    //    }
}

import SwiftUI
struct MovieListView33Controller_Previews: PreviewProvider {
    static var previews: some View {
        Container().edgesIgnoringSafeArea(.all)
    }
    
    struct Container: UIViewControllerRepresentable {
        func makeUIViewController(context: Context) -> UIViewController {
            let vc = MovieReviewViewController()
            return UINavigationController(rootViewController: vc)
        }
        
        func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) { }
        
        typealias UIViewControllerType = UIViewController
    }
}

