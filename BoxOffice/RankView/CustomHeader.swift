//
//  CustomHeader.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/18.
//

import UIKit

class CustomHeader : UITableViewHeaderFooterView{
    
    static let id = "header"
    
    let appTitleLable : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.text = "박스오피스"
        lbl.font = .preferredFont(for: .largeTitle,weight: .bold)
        //lbl.font = .boldSystemFont(ofSize: 40)
        return lbl
    }()
    let dateLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
    //    lbl.font = .preferredFont(forTextStyle: .caption2)
        lbl.font = .systemFont(ofSize: 18)
        return lbl
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        addSubViews()
        setConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        self.addSubview(appTitleLable)
        self.addSubview(dateLabel)
  
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            appTitleLable.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            appTitleLable.bottomAnchor.constraint(equalTo: dateLabel.topAnchor),
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            dateLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
    }
}
