//
//  MoviesListTableViewCell.swift
//  BoxOffice
//
//  Created by channy on 2022/10/21.
//

import UIKit

class MoviesListTableViewCell: UITableViewCell {
    
    static let identifier = "moviesListCell"
    lazy var cellContentView = MoviesListTableViewCellContentView()
    
    var viewModel: MoviesListItemViewModel? {
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
    
    func fill(viewModel: MoviesListItemViewModel) {
        self.viewModel = viewModel
        self.selectionStyle = .none
        self.separatorInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: -20)
        
        setupViews()
        setupConstraints()
        bind()
    }
    
}

extension MoviesListTableViewCell {
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
