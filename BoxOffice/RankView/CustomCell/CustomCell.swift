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
        
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setConstraints()
        self.selectionStyle = .none
        self.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        self.contentView.addSubview(infoGroupView)
        infoGroupView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            infoGroupView.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor),
            infoGroupView.topAnchor.constraint(equalTo: self.contentView.topAnchor),
            infoGroupView.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor),
            infoGroupView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0))
    }
 
    
}
