//
//  GroupView.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/17.
//

import UIKit

class InfoGroupView : UIView{
    
    let posterImageView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    let titleLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 36)
        return lbl
    }()
    let releaseDateLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 18)
        return lbl
    }()
    let numOfAudienceLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 18)
        return lbl
    }()
    lazy var stackViewV : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,releaseDateLabel,numOfAudienceLabel])
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 20
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setConstraints()
        self.layer.cornerRadius = 10
        self.clipsToBounds = true
        self.backgroundColor = .secondarySystemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        self.addSubview(stackViewV)
        self.addSubview(posterImageView)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            stackViewV.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            stackViewV.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
            stackViewV.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalTo: stackViewV.heightAnchor),
            posterImageView.widthAnchor.constraint(equalTo:posterImageView.heightAnchor,multiplier: 2 / 3),
            posterImageView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            posterImageView.trailingAnchor.constraint(equalTo: stackViewV.leadingAnchor)
        ])
    }
    
    func setInfo(posterImage:UIImage?,title:String, releaseDate:String, numOfAudience:String){
        posterImageView.image = posterImage
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
        numOfAudienceLabel.text = numOfAudience
    }
}

