//
//  BoxOfficeView.swift
//  BoxOffice
//
//  Created by KangMingyo on 2022/10/17.
//

import UIKit

class BoxOfficeView: UIView {
    
    let boxOfficeTableView: UITableView = {
         let tableView = UITableView()
         tableView.rowHeight = 150
         tableView.translatesAutoresizingMaskIntoConstraints = false
         return tableView
     }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addView()
        configure()
    }
    
    required init?(coder NSCoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addView() {
        addSubview(boxOfficeTableView)
    }
    
    func configure() {
        NSLayoutConstraint.activate([
            
            boxOfficeTableView.topAnchor.constraint(equalTo: topAnchor),
            boxOfficeTableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            boxOfficeTableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            boxOfficeTableView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}


