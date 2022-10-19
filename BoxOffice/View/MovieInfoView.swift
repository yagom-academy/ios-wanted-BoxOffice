//
//  DetailView.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/19.
//

import UIKit

class MovieInfoView: UIView {
    
    let movieInfoTableView: UITableView = {
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
        addSubview(movieInfoTableView)
        let safeArea = self.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            movieInfoTableView.topAnchor.constraint(equalTo: safeArea.topAnchor),
            movieInfoTableView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor),
            movieInfoTableView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor),
            movieInfoTableView.bottomAnchor.constraint(equalTo: safeArea.bottomAnchor)
        ])
    }

}
