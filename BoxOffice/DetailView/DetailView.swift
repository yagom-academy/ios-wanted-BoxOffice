//
//  DetailView.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/18.
//

import UIKit

class DetailView : UIView {
    
    let scrollView = UIScrollView()
    
    let newLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "New"
        lbl.textColor = .systemYellow
        lbl.font = .boldSystemFont(ofSize: 30)
        return lbl
    }()
        
    let posterView : UIImageView = {
        let imgView = UIImageView()
        imgView.layer.cornerRadius = 10
        imgView.clipsToBounds = true
        return imgView
    }()
    
    let rankLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 36)
        lbl.backgroundColor = .systemBackground.withAlphaComponent(0.5)
        lbl.textAlignment = .center
        lbl.textColor = .label
        return lbl
    }()
                
    let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 36)
        lbl.numberOfLines = 0
        lbl.lineBreakMode = .byCharWrapping
        lbl.textAlignment = .center
        return lbl
    }()
    
    let tableInfoView = TableInfoView()
    
    lazy var stackV : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [newLabel,posterView,titleLabel,tableInfoView])
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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        self.addSubview(scrollView)
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.addSubview(stackV)
        scrollView.addSubview(newLabel)
        posterView.addSubview(rankLabel)
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
            rankLabel.leadingAnchor.constraint(equalTo: posterView.leadingAnchor),
            rankLabel.topAnchor.constraint(equalTo: posterView.topAnchor),
            rankLabel.widthAnchor.constraint(equalTo: rankLabel.heightAnchor),
            newLabel.bottomAnchor.constraint(equalTo: posterView.topAnchor),
            newLabel.centerXAnchor.constraint(equalTo: posterView.centerXAnchor)
        ])
    }

    func setInfo(movie:Movie){
        newLabel.isHidden = movie.boxOfficeInfo.rankOldAndNew == "NEW" ? false : true
        posterView.image = movie.poster
        titleLabel.text = movie.boxOfficeInfo.movieNm
        rankLabel.text = movie.boxOfficeInfo.rank
        tableInfoView.setInfo(releaseDate: movie.boxOfficeInfo.openDt, filmYear: movie.detailInfo.prdtYear, playTime: movie.detailInfo.showTm, genre: movie.detailInfo.genres[0].genreNm, director: movie.detailInfo.directors[0].peopleNm, actor: movie.detailInfo.actors, rate: movie.detailInfo.audits[0].watchGradeNm, numOfAudience: movie.boxOfficeInfo.audiAcc)
    }
}
