//
//  GroupView.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/17.
//

import UIKit

class InfoGroupView : UIView{
    
    let rankLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 20)
        lbl.backgroundColor = .systemBackground.withAlphaComponent(0.5)
        lbl.textAlignment = .center
        lbl.textColor = .label
        return lbl
    }()
    let newLabel : PaddingLabel = {
        let lbl = PaddingLabel(padding: UIEdgeInsets(top: 0, left: 5, bottom: 0, right: 5))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "New"
        lbl.textColor = .systemYellow
        lbl.backgroundColor = .systemBackground.withAlphaComponent(0.5)
        lbl.font = .boldSystemFont(ofSize: 20)
        return lbl
    }()
    let posterView : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        imgView.layer.cornerRadius = 7
        imgView.clipsToBounds = true
        return imgView
    }()
    let titleLabel : PaddingLabel = {
        let lbl = PaddingLabel(padding: UIEdgeInsets(top: 0, left: 7, bottom: 0, right: 7))
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .preferredFont(for: .title1, weight: .semibold)
        lbl.numberOfLines = 0
        lbl.textAlignment = .center
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
    let rankDiffImage : UIImageView = {
        let imgView = UIImageView()
        imgView.translatesAutoresizingMaskIntoConstraints = false
        return imgView
    }()
    let rankDiffLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .systemFont(ofSize: 18)
        return lbl
    }()
    lazy var stackViewH : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [rankDiffImage,rankDiffLabel])
        stackView.distribution = .fillProportionally
        stackView.spacing = 2
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()
    lazy var stackViewV : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,releaseDateLabel,numOfAudienceLabel,stackViewH])
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 0
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
        self.addSubview(posterView)
        posterView.addSubview(rankLabel)
        posterView.addSubview(newLabel)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            stackViewV.topAnchor.constraint(equalTo: self.topAnchor,constant: 10),
            stackViewV.bottomAnchor.constraint(equalTo: self.bottomAnchor,constant: -10),
            stackViewV.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            posterView.heightAnchor.constraint(equalTo: stackViewV.heightAnchor),//,multiplier: 0.9),
            posterView.widthAnchor.constraint(equalTo:posterView.heightAnchor,multiplier: 2 / 3),
            posterView.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            posterView.leadingAnchor.constraint(equalTo: self.leadingAnchor,constant: 10),
            posterView.trailingAnchor.constraint(equalTo: stackViewV.leadingAnchor),
            titleLabel.heightAnchor.constraint(equalTo: stackViewV.heightAnchor,multiplier: 0.5),
            releaseDateLabel.heightAnchor.constraint(equalTo: stackViewV.heightAnchor,multiplier: 0.5 / 3),
            numOfAudienceLabel.heightAnchor.constraint(equalTo: stackViewV.heightAnchor,multiplier: 0.5 / 3),
            stackViewH.heightAnchor.constraint(equalTo: stackViewV.heightAnchor,multiplier: 0.5 / 3),
            rankLabel.leadingAnchor.constraint(equalTo: posterView.leadingAnchor),
            rankLabel.topAnchor.constraint(equalTo: posterView.topAnchor),
            rankLabel.widthAnchor.constraint(equalTo: rankLabel.heightAnchor),
            newLabel.trailingAnchor.constraint(equalTo: posterView.trailingAnchor),
            newLabel.topAnchor.constraint(equalTo: posterView.topAnchor),
        ])
    }
    
    func setInfo(posterImage:UIImage,title:String, releaseDate:String, numOfAudience:String, rank:String, upAndDown:String, isNew:String){
        posterView.image = posterImage
        rankLabel.text = rank
        titleLabel.text = title
        releaseDateLabel.text = releaseDate
        numOfAudienceLabel.text = numOfAudience.isOverTenThousand()
        setUpAndDown(upAndDown:upAndDown)
        newLabel.isHidden = isNew == "NEW" ? false : true
    }
    
    func setUpAndDown(upAndDown:String){
        if let upAndDown = Int(upAndDown), upAndDown == 0{
            rankDiffImage.image = UIImage(systemName: "equal")
            rankDiffImage.tintColor = .label
            rankDiffLabel.textColor = .label
            rankDiffLabel.text = ""
            return
        }else if let upAndDown = Int(upAndDown), upAndDown > 0{
            rankDiffImage.image = UIImage(systemName: "arrowtriangle.up.fill")
            rankDiffImage.tintColor = .green
            rankDiffLabel.textColor = .green
            rankDiffLabel.text = String(upAndDown)
        }else if let upAndDown = Int(upAndDown), upAndDown < 0{
            rankDiffImage.image = UIImage(systemName: "arrowtriangle.down.fill")
            rankDiffImage.tintColor = .red
            rankDiffLabel.textColor = .red
            let positive = String(upAndDown * -1)
            rankDiffLabel.text = positive
        }
    }
}

