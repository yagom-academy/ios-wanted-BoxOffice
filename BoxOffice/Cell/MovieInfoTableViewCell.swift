//
//  MovieInfoTableViewCell.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/19.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell {
    
    var cellViewModel: MovieInfoCellViewModel? {
        didSet {
            guard let viewModel = cellViewModel else { return }
            label.text = viewModel.cellData.movieNm
            
        }
    }
    
    private let label: UILabel = {
        let view = UILabel()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //self.selectionStyle = .none
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(label)
        print("123")
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: topAnchor),
            label.leadingAnchor.constraint(equalTo: leadingAnchor)
        ])
    }
}
