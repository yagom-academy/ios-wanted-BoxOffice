//
//  RateView.swift
//  BoxOffice
//
//  Created by 천승희 on 2023/01/06.
//

import UIKit

class RateView: BaseView {
    var starNumber: Int = 5 {
        didSet { bind() }
    }
    var currentStar: Int = 0
    
    private var buttons: [UIButton] = []
    
    lazy var stackView: UIStackView = {
        let view = UIStackView()
        view.axis = .horizontal
        view.spacing = 12
        view.backgroundColor = .white

        return view
    }()
    
    lazy var starFillImage: UIImage? = {
        return UIImage(systemName: "star.fill")
    }()

    lazy var starEmptyImage: UIImage? = {
        return UIImage(systemName: "star")
    }()
    
    override func configure() {
        super.configure()

        starNumber = 5
        addSubviews()
        setupLayout()
    }

    private func addSubviews() {
        addSubview(stackView)
    }

    private func setupLayout() {
        stackView.translatesAutoresizingMaskIntoConstraints = false

        stackView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        stackView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        stackView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        stackView.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    
    override func bind() {
        super.bind()

        for i in 0..<5 {
            let button = UIButton()
            button.setImage(starEmptyImage, for: .normal)
            button.tag = i
            buttons += [button]
            stackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(didTapButton(sender:)), for: .touchUpInside)
        }
    }
}

extension RateView {
    @objc
    private func didTapButton(sender: UIButton) {
        let end = sender.tag

        for i in 0...end {
            buttons[i].setImage(starFillImage, for: .normal)
        }
        for i in end + 1..<starNumber {
            buttons[i].setImage(starEmptyImage, for: .normal)
        }

        currentStar = end + 1
    }
}
