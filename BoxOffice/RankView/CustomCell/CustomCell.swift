//
//  CustomCell.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/17.
//

import UIKit

class CustomCell : UITableViewCell {
    
    static let id = "cell"
    
    let infoGroupView = InfoGroupView()
    
    let rankGroupView = RankGroupView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setConstraints()
       self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        self.contentView.addSubview(infoGroupView)
        self.contentView.addSubview(rankGroupView)
        infoGroupView.translatesAutoresizingMaskIntoConstraints = false
        rankGroupView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints(){
        let inset : CGFloat = 20
        let rankGroupViewWidth : CGFloat = (self.frame.width - inset) * 0.2
        let infoGroupViewWidth : CGFloat = self.frame.width - rankGroupViewWidth
        NSLayoutConstraint.activate([
            rankGroupView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            rankGroupView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            rankGroupView.widthAnchor.constraint(equalToConstant: rankGroupViewWidth),
            rankGroupView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            rankGroupView.trailingAnchor.constraint(equalTo: infoGroupView.leadingAnchor,constant: -inset),
            infoGroupView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            infoGroupView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            infoGroupView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            infoGroupView.widthAnchor.constraint(equalToConstant: infoGroupViewWidth)
        ])
    }
    
    override func layoutSubviews() {
        print("called")
        super.layoutSubviews()
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20))
    }
 
    
}
