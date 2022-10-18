//
//  RankGroupView.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/18.
//

import UIKit

class RankGroupView : UIView{
    
    let newLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "New"
        lbl.textColor = .systemYellow
        lbl.font = .boldSystemFont(ofSize: 18)
        return lbl
    }()
    let rankLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .boldSystemFont(ofSize: 36)
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
        let stackView = UIStackView(arrangedSubviews: [newLabel,rankLabel,stackViewH])
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        self.addSubview(stackViewV)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            stackViewV.topAnchor.constraint(equalTo: self.topAnchor),
            stackViewV.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            stackViewV.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            stackViewV.trailingAnchor.constraint(equalTo: self.trailingAnchor)
        ])
    }
    
    func setInfo(isNew:Bool, rank:String, upAndDown:String){
        newLabel.text = isNew ? "New" : "  "
        rankLabel.text = rank
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
