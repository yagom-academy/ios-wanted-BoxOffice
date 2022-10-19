//
//  StarScore.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/20.
//

import UIKit

class StarScore: UIView {
    
    lazy var starStackView: UIStackView = {
        let stack = UIStackView()
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    lazy var starFillImage: UIImage? = {
        return UIImage(systemName: "star.fill")
    }()
    
    lazy var starEmptyImage: UIImage? = {
        return UIImage(systemName: "star")
    }()
    
    var buttons: [UIButton] = []
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupView() {
        for i in 0 ..< 5 {
            let button = UIButton()
            button.setImage(starEmptyImage, for: .normal)
            button.tag = i
            buttons.append(button)
            starStackView.addArrangedSubview(button)
            button.addTarget(self, action: #selector(starButtonClicked(sender:)), for: .touchUpInside)
        }
    }
    
    func setupConstraints() {
        addSubview(starStackView)
        NSLayoutConstraint.activate([
            starStackView.topAnchor.constraint(equalTo: topAnchor),
            starStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            starStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            starStackView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
    }
    
    @objc func starButtonClicked(sender: UIButton) {
        print("dsd")
    }
    
}
