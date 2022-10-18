//
//  DetailView.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/18.
//

import UIKit

class DetailView : UIView {
    
    let scrollView = UIScrollView()
    
    let posterView = UIImageView()
    
    let rankGroudView = RankGroupViewForDetailView()
        
    let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 36)
        lbl.text = "아이언맨"
        return lbl
    }()
    
    lazy var stackH : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rankGroudView,titleLabel])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 30
        stackView.axis = .horizontal
        stackView.alignment = .bottom
        return stackView
    }()
    
    let tableInfoView = TableInfoView()
    
    
    lazy var stackV : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [posterView,stackH,tableInfoView])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setConstraints()
        scrollView.backgroundColor = .systemBackground
        posterView.image = UIImage(named: "James")
        rankGroudView.setInfo(isNew: true, rank: "3", isUp: true, rankDiff: "2")
        tableInfoView.setInfo(releaseDate: "2012/12/28", filmYear: "2010", playTime: "120분", genre: "액션", director: "루소 형제", actor: "로버트 다우니 주니어", rate: "12세", numOfAudience: "120M")
      //  scrollView.contentInsetAdjustmentBehavior = .never
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackV)
      //  tableView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            scrollView.topAnchor.constraint(equalTo: self.topAnchor),
            scrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            posterView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.6),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 3 / 2),
            stackV.topAnchor.constraint(equalTo: scrollView.topAnchor),
            stackV.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            stackV.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            stackV.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            stackV.widthAnchor.constraint(equalTo: scrollView.widthAnchor),
            tableInfoView.widthAnchor.constraint(equalTo: scrollView.widthAnchor, multiplier: 0.8),
        ])
    }


}
