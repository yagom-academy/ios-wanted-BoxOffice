//
//  MoviesListTableViewCellContentView.swift
//  BoxOffice
//
//  Created by channy on 2022/10/21.
//

import UIKit

class MoviesListTableViewCellContentView: UIView {
    
    // Input
    var didReceiveViewModel: (MoviesListItemViewModel) -> () = { viewModel in }
    
    var viewModel: MoviesListItemViewModel?
    
    let rankLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 23, weight: .bold)
        label.textColor = .black
        
        return label
    }()
    
    let newLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .heavy)
        label.textColor = .systemRed
        label.text = "New"
        
        return label
    }()
    
    let plusLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 15, weight: .heavy)
        label.textColor = .darkGray
        label.text = "-"
        
        return label
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 22, weight: .semibold)
        label.textColor = .black
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        label.textColor = .darkGray
        
        return label
    }()
    
    let audienceIcon: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.image = UIImage(systemName: "person.fill")
        view.tintColor = .darkGray
        
        return view
    }()
    
    let audienceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .medium)
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

extension MoviesListTableViewCellContentView {
    func setupViews() {
        let views = [rankLabel, newLabel, plusLabel, titleLabel, dateLabel, audienceIcon, audienceLabel]
        views.forEach { self.addSubview($0) }
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            rankLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            rankLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            rankLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -30),
        ])
        
        NSLayoutConstraint.activate([
            newLabel.centerXAnchor.constraint(equalTo: rankLabel.centerXAnchor),
            newLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            plusLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 75),
            plusLabel.centerYAnchor.constraint(equalTo: self.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 110),
            titleLabel.widthAnchor.constraint(equalToConstant: 160),
            titleLabel.centerYAnchor.constraint(equalTo: rankLabel.centerYAnchor)
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 3)
        ])
        
        NSLayoutConstraint.activate([
            audienceIcon.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 7),
            audienceIcon.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            audienceIcon.widthAnchor.constraint(equalToConstant: 25),
            audienceIcon.heightAnchor.constraint(equalToConstant: 25),
        ])
        
        NSLayoutConstraint.activate([
            audienceLabel.leadingAnchor.constraint(equalTo: audienceIcon.trailingAnchor, constant: 5),
            audienceLabel.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            audienceLabel.centerYAnchor.constraint(equalTo: audienceIcon.centerYAnchor)
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
            self.dateLabel.text = viewModel.openDt
            self.audienceLabel.text = viewModel.audiAcc
            
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
