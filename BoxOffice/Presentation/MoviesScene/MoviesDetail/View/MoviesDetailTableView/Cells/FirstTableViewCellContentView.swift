//
//  FirstTableViewCellContentView.swift
//  BoxOffice
//
//  Created by channy on 2022/10/22.
//

import UIKit

class FirstTableViewCellContentView: UIView {
    
    // Input
    var didReceiveViewModel: (MoviesDetailItemViewModel) -> () = { viewModel in }
    
    var viewModel: MoviesDetailItemViewModel?
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 25, weight: .bold)
        label.textColor = .black
        label.sizeToFit()
        
        return label
    }()
    
    let newLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        label.textColor = .systemRed
        label.text = "New"
        label.sizeToFit()
        
        return label
    }()
    
    let plusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 20, weight: .heavy)
        label.textColor = .darkGray
        label.text = "-"
        label.sizeToFit()
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0
        label.font = UIFont.systemFont(ofSize: 27, weight: .semibold)
        label.textColor = .black
        label.sizeToFit()
        
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

extension FirstTableViewCellContentView {
    func setupViews() {
        let views = [rankLabel, newLabel, plusLabel, titleLabel,]
        views.forEach { self.addSubview($0) }
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            rankLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            rankLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
//            rankLabel.widthAnchor.constraint(equalToConstant: 55)
        ])
        
        NSLayoutConstraint.activate([
            newLabel.centerXAnchor.constraint(equalTo: rankLabel.centerXAnchor),
            newLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor),
        ])
        
        NSLayoutConstraint.activate([
            plusLabel.leadingAnchor.constraint(equalTo: self.rankLabel.trailingAnchor, constant: 10),
            plusLabel.centerYAnchor.constraint(equalTo: self.rankLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.plusLabel.trailingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -20),
            titleLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 30),
            titleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40),
        ])
    }
    
    func bind() {
        didReceiveViewModel = { [weak self] viewModel in
            guard let self = self else { return }
            self.viewModel = viewModel
            
            guard let viewModel = self.viewModel else { return }
            self.rankLabel.text = viewModel.getRankString(viewModel.rank)
            self.newLabel.isHidden = viewModel.isNewLabelHidden(viewModel.rankOldAndNew)
            self.titleLabel.text = viewModel.movieNm
            
            switch viewModel.isPlus(viewModel.rankInten) {
            case 1:
                self.plusLabel.textColor = .systemRed
                self.plusLabel.text = "+" + viewModel.rankInten
            case -1:
                self.plusLabel.textColor = .systemBlue
                self.plusLabel.text = viewModel.rankInten
            default:
                self.plusLabel.text = " -"
            }
        }
    }
}

