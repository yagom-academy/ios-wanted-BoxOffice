//
//  StarImageView.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/04.
//

import UIKit

final class StarImageView: UIImageView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        self.image = UIImage(systemName: "star")
        self.tintColor = .systemYellow
        self.translatesAutoresizingMaskIntoConstraints = false
    }
}
