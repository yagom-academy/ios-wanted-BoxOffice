//
//  MoviesDetailTableView.swift
//  BoxOffice
//
//  Created by channy on 2022/10/22.
//

import UIKit

class MoviesDetailTableView: UITableView {
    
    override init(frame: CGRect, style: UITableView.Style) {
        super.init(frame: frame, style: style)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.separatorStyle = .none
        
        self.register(FirstTableViewCell.self, forCellReuseIdentifier: FirstTableViewCell.identifier)
        self.register(SecondTableViewCell.self, forCellReuseIdentifier: SecondTableViewCell.identifier)
        self.register(ThirdTableViewCell.self, forCellReuseIdentifier: ThirdTableViewCell.identifier)
    }
    
    @available(*, unavailable)
    required init?(coder _: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
