//
//  BoxOfficeView.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/18.
//

import UIKit

class BoxOfficeView: UIView {
    
    let boxOfficeTableView: UITableView = {
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
        addSubview(boxOfficeTableView)
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            boxOfficeTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            boxOfficeTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            boxOfficeTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            boxOfficeTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }
    
}
