//
//  ThirdTableViewCellContentView.swift
//  BoxOffice
//
//  Created by channy on 2022/10/22.
//

import UIKit

class ThirdTableViewCellContentView: UIView {
    
    // Input
    var didReceiveViewModel: (MoviesDetailItemViewModel) -> () = { viewModel in }
    
    var viewModel: MoviesDetailItemViewModel?
    
    let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.text = "감독 / 배우"
        label.textColor = .black
        
        return label
    }()
    
    let dirTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.text = "감독  "
        label.textColor = .black
        
        return label
    }()
    
    let directorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        
        return label
    }()
    
    let actorTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.text = "배우  "
        label.textColor = .black
        
        return label
    }()
    
    let actorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        
        return label
    }()
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        setupViews()
        setupConstraints()
        bind()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension ThirdTableViewCellContentView {
    func setupViews() {
        let views = [cellTitleLabel, dirTitleLabel, directorLabel, actorTitleLabel, actorLabel]
        views.forEach { self.addSubview($0) }
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            cellTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            cellTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            dirTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            dirTitleLabel.topAnchor.constraint(equalTo: self.cellTitleLabel.bottomAnchor, constant: 20),
            dirTitleLabel.widthAnchor.constraint(equalToConstant: 40),
        ])
        
        NSLayoutConstraint.activate([
            directorLabel.leadingAnchor.constraint(equalTo: self.dirTitleLabel.trailingAnchor, constant: 5),
            directorLabel.centerYAnchor.constraint(equalTo: self.dirTitleLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            actorTitleLabel.leadingAnchor.constraint(equalTo: self.dirTitleLabel.leadingAnchor),
            actorTitleLabel.widthAnchor.constraint(equalToConstant: 40),
            actorTitleLabel.topAnchor.constraint(equalTo: self.dirTitleLabel.bottomAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            actorLabel.leadingAnchor.constraint(equalTo: self.actorTitleLabel.trailingAnchor, constant: 5),
            actorLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            actorLabel.topAnchor.constraint(equalTo: self.dirTitleLabel.bottomAnchor, constant: 20),
            actorLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor),
        ])
    }
    
    func bind() {
        didReceiveViewModel = { [weak self] viewModel in
            guard let self = self else { return }
            self.viewModel = viewModel
            
            guard let viewModel = self.viewModel else { return }
            self.directorLabel.text = viewModel.getDirectorString(viewModel.directorsNm)
            self.actorLabel.text = viewModel.getActorString(viewModel.actorsNm)
        }
    }
}
