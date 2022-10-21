//
//  MoviesListTableView.swift
//  BoxOffice
//
//  Created by channy on 2022/10/21.
//

import UIKit

class MoviesListTableView: UITableView {
    
    lazy var cellContentView = MoviesListTableViewCellContentView()
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.register(MoviesListTableViewCell.self, forCellReuseIdentifier: MoviesListTableViewCell.identifier)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
