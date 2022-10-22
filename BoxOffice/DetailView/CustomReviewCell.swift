//
//  CustomReviewCell.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/21.
//

import UIKit

class CustomReviewCell : UITableViewCell{
    
    static let id = "reviewCell"
    
    let profileView = UIImageView()
    
    let nickNameLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .preferredFont(forTextStyle: .body)
        return lbl
    }()
    
    let starImageView1 = UIImageView()
    let starImageView2 = UIImageView()
    let starImageView3 = UIImageView()
    let starImageView4 = UIImageView()
    let starImageView5 = UIImageView()
    
    lazy var starArr = [starImageView1,starImageView2,starImageView3,starImageView4,starImageView5]
    
    lazy var starStackH : UIStackView = {
        let stackView = UIStackView(arrangedSubviews: starArr)
        _ = starArr.map{
            $0.image = UIImage(systemName: "star.fill")
            $0.tintColor = .systemYellow
        }
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 0
        return stackView
    }()
    
    let reviewLabel : UILabel = {
        let lbl = UILabel()
        lbl.translatesAutoresizingMaskIntoConstraints = false
        lbl.font = .preferredFont(forTextStyle: .subheadline)
        lbl.numberOfLines = 0
        return lbl
    }()
    
    lazy var deleteButton : UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.setTitle("삭제", for: .normal)
        btn.backgroundColor = .systemRed
        btn.layer.cornerRadius = 10
        btn.addTarget(self, action: #selector(deleteReview), for: .touchUpInside)
        return btn
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addSubViews()
        setConstraints()
        makeProfileViewCircle()
        self.selectionStyle = .none
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addSubViews(){
        self.contentView.addSubview(profileView)
        profileView.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(nickNameLabel)
        self.contentView.addSubview(starStackH)
        self.contentView.addSubview(reviewLabel)
        self.contentView.addSubview(deleteButton)
    }
    
    func setConstraints(){
        NSLayoutConstraint.activate([
            profileView.topAnchor.constraint(equalTo: self.contentView.topAnchor,constant: 10),
            profileView.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor,constant: 20),
            profileView.widthAnchor.constraint(equalTo: self.contentView.widthAnchor, multiplier: 0.1),
            profileView.heightAnchor.constraint(equalTo:  profileView.widthAnchor),
            nickNameLabel.leadingAnchor.constraint(equalTo: profileView.trailingAnchor, constant: 5),
            nickNameLabel.bottomAnchor.constraint(equalTo: profileView.bottomAnchor),
            starStackH.leadingAnchor.constraint(equalTo: nickNameLabel.trailingAnchor, constant: 3),
            starStackH.bottomAnchor.constraint(equalTo: profileView.bottomAnchor),
            starStackH.trailingAnchor.constraint(lessThanOrEqualTo: self.contentView.trailingAnchor, constant: -20),
            reviewLabel.topAnchor.constraint(equalTo: profileView.bottomAnchor, constant: 10),
            reviewLabel.leadingAnchor.constraint(equalTo:  self.contentView.leadingAnchor, constant: 20),
            reviewLabel.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -20),
            reviewLabel.bottomAnchor.constraint(equalTo:  deleteButton.topAnchor, constant: -10),
            deleteButton.trailingAnchor.constraint(equalTo:  self.contentView.trailingAnchor, constant: -20),
            deleteButton.bottomAnchor.constraint(equalTo: self.contentView.bottomAnchor,constant: -10),
            deleteButton.widthAnchor.constraint(equalTo: self.contentView.widthAnchor,multiplier: 0.25)
        ])
    }
    
    func makeProfileViewCircle(){
        let width = UIScreen.main.bounds.width * 0.1
        profileView.layer.cornerRadius = width / 2
        profileView.clipsToBounds = true
        profileView.contentMode = .scaleAspectFill
    }
    
    @objc func deleteReview(){
        FirebaseStorageManager.shared.delete()
    }
    
}
