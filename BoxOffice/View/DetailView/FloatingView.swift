//
//  FloatingView.swift
//  BoxOffice
//
//  Created by sole on 2022/10/20.
//

import UIKit

class FloatingView: UIView {
    private let backgroundView: UIImageView = {
       let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "gradientBlue")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        button.contentMode = .scaleAspectFill
        return button
    }()
    
    let reviewButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("✏️ 리뷰쓰기", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 15, weight: .bold)
        button.tintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureHierarchy() {
        [backgroundView, shareButton, reviewButton].forEach { addSubview($0) }
        NSLayoutConstraint.activate([
            backgroundView.widthAnchor.constraint(equalTo: self.widthAnchor),
            backgroundView.heightAnchor.constraint(equalTo: backgroundView.widthAnchor, multiplier: 0.3),
            backgroundView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            backgroundView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            shareButton.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            shareButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor, constant: -60),
            
            reviewButton.centerYAnchor.constraint(equalTo: backgroundView.centerYAnchor),
            reviewButton.centerXAnchor.constraint(equalTo: backgroundView.centerXAnchor, constant: 15)
        ])
    }
}
