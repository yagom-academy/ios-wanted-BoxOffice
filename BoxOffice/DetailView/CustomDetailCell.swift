//
//  CustomDetailCell.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/18.
//

import UIKit

class CustomDetailCell: UITableViewCell {
    
    static let id = "detailCell"
    
    let subjectLabel : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 15)
        return lbl
    }()
    let answerLabel : UILabel = {
        let lbl = UILabel()
        lbl.textAlignment = .left
        lbl.font = .systemFont(ofSize: 15)
        return lbl
    }()

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
        self.contentView.addSubview(subjectLabel)
        self.contentView.addSubview(answerLabel)
        subjectLabel.translatesAutoresizingMaskIntoConstraints = false
        answerLabel.translatesAutoresizingMaskIntoConstraints = false
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            subjectLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor,multiplier: 0.5),
            subjectLabel.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor),
            answerLabel.widthAnchor.constraint(equalTo: self.contentView.widthAnchor,multiplier: 0.5),
            answerLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor)
        ])
    }
    
    override func layoutSubviews() {
        print("called")
        super.layoutSubviews()
        self.contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20))
    }
    
}
