//
//  ReviewCell.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/21.
//

import UIKit

class ReviewCell: UITableViewCell {
    
    var cellViewModel: ReviewCellViewModel? {
        didSet {
            guard let viewModel = cellViewModel else { return }
            nicknameLabel.text = viewModel.cellData.nickname
            myImageView.setImageUrl(viewModel.cellData.imageURL)
            scoreLabel.text = "평점 \(viewModel.cellData.score) / 5"
            reviewLabel.text = viewModel.cellData.text
            id = viewModel.cellData.id
            
        }
    }
    var id = UUID()
    var deleteButtonAction: (() -> ()) = {}
    
    var containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.00).cgColor
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var myImageView: UIImageView = {
        let view = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        view.layer.cornerRadius = 0.5 * view.bounds.size.width
        view.backgroundColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nicknameLabel: UILabel = {
        let view = UILabel()
        view.text = "동동이"
        view.font = .systemFont(ofSize: 18)
        view.textColor = UIColor(red: 0.51, green: 0.51, blue: 0.51, alpha: 1.00)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let scoreLabel: UILabel = {
        let view = UILabel()
        view.text = "평점 3 / 5"
        view.font = .boldSystemFont(ofSize: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let reviewLabel: UILabel = {
        let view = UILabel()
        view.text = ""
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let deleteButton: DeleteButton = {
        let view = DeleteButton()
        view.layer.cornerRadius = 5
        view.setTitle("삭제", for: .normal)
        view.setTitleColor(UIColor.red, for: .normal)
        view.titleLabel?.font = .boldSystemFont(ofSize: 18)
        view.clipsToBounds = true
        view.layer.borderColor = UIColor.red.cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .white
        view.addTarget(self, action: #selector(deleteButtonClicked), for: .touchUpInside)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.cellViewModel = nil
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //self.selectionStyle = .none
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        contentView.addSubview(containerView)
        containerView.addSubview(reviewLabel)
        containerView.addSubview(myImageView)
        containerView.addSubview(nicknameLabel)
        containerView.addSubview(scoreLabel)
        containerView.addSubview(deleteButton)
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
            
            
            myImageView.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            myImageView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            myImageView.widthAnchor.constraint(equalToConstant: 50),
            myImageView.heightAnchor.constraint(equalToConstant: 50),
            
            nicknameLabel.topAnchor.constraint(equalTo: myImageView.topAnchor),
            nicknameLabel.leadingAnchor.constraint(equalTo: myImageView.trailingAnchor, constant: 20),
            
            deleteButton.topAnchor.constraint(equalTo: nicknameLabel.topAnchor),
            deleteButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            deleteButton.widthAnchor.constraint(equalToConstant: 56),
            
            scoreLabel.topAnchor.constraint(equalTo: nicknameLabel.bottomAnchor, constant: 8),
            scoreLabel.leadingAnchor.constraint(equalTo: nicknameLabel.leadingAnchor),
            
            reviewLabel.topAnchor.constraint(equalTo: myImageView.bottomAnchor, constant: 12),
            reviewLabel.leadingAnchor.constraint(equalTo: scoreLabel.leadingAnchor),
            reviewLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            reviewLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
            
            
        ])
    }
    
    @objc func deleteButtonClicked() {
        deleteButtonAction()
    }
}

