//
//  FirstTableViewCell.swift
//  BoxOffice
//
//  Created by channy on 2022/10/22.
//

import UIKit

class FirstTableViewCell: UITableViewCell {
    
    static let identifier = "FirstCell"
    lazy var cellContentView = FirstTableViewCellContentView()
    
    var viewModel: MoviesDetailItemViewModel? {
        didSet {
            guard let viewModel else { return }
            cellContentView.didReceiveViewModel(viewModel)
        }
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func fill(viewModel: MoviesDetailItemViewModel) {
        self.viewModel = viewModel
        self.selectionStyle = .none
        
        setupViews()
        setupConstraints()
        bind()
    }
    
}

extension FirstTableViewCell {
    func setupViews() {
        let views = [cellContentView]
        views.forEach { self.contentView.addSubview($0) }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            cellContentView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            cellContentView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            cellContentView.topAnchor.constraint(equalTo: contentView.topAnchor),
            cellContentView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ])
    }
    
    func bind() {
    }
}
