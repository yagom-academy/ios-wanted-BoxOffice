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
        setupTableView()
    }
    
    required init?(coder NSCoder : NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTableView() {
        boxOfficeTableView.delegate = self
        boxOfficeTableView.dataSource = self
        boxOfficeTableView.register(BoxOfficeTableViewCell.self, forCellReuseIdentifier: "cell")
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

extension BoxOfficeView: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = boxOfficeTableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! BoxOfficeTableViewCell
        cell.posterImageView.image = UIImage(named: "poster")
        cell.rankOldAndNew.text = "New"
        cell.movieName.text = "영화이름"
        cell.openDate.text = "2022-10-13"
        cell.boxOfficeRank.text = "1"
        cell.rankInten.text = "-1"
        cell.audiAcc.text = "620만"
    
        return cell
    }
    
    
}
