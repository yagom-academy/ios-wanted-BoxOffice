//
//  DetailView.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/19.
//

import UIKit

class DetailView: UIView {
    
    let detailTableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.separatorStyle = .none
        return view
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        
    }

}
