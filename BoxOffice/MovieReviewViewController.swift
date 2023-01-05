//
//  MovieReviewViewController.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/05.
//

import UIKit

final class MovieReviewViewController: UIViewController {

    private let questionLabel: UILabel = {
        let label = UILabel()
        label.text = "영화 어떠셨나요?"
        return label
    }()
    
    private let reviewRequestLabel: UILabel = {
        let label = UILabel()
        label.text = "관람평을 남겨주세요."
        return label
    }()
    
    private let userInformationStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "별명"
        return textField
    }()
    
    private let passwordTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "암호"
        return textField
    }()
    
    private let reviewTextView: UITextView = {
        let textView = UITextView()
        return textView
    }()
    
    private let photoAddingButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let actionButtonStackView: UIStackView = {
        let stackView = UIStackView()
        return stackView
    }()
    
    private let cancelButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    private let registrationButton: UIButton = {
        let button = UIButton()
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .systemBackground
    }

}
