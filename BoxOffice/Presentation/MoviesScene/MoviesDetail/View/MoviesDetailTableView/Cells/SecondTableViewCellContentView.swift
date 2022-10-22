//
//  SecondTableViewCellContentView.swift
//  BoxOffice
//
//  Created by channy on 2022/10/22.
//

import UIKit

class SecondTableViewCellContentView: UIView {
    
    // Input
    var didReceiveViewModel: (MoviesDetailItemViewModel) -> () = { viewModel in }
    
    var viewModel: MoviesDetailItemViewModel?
    
    let cellTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 25, weight: .heavy)
        label.text = "상세 정보"
        label.textColor = .black
        
        return label
    }()
    
    let dateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        
        return label
    }()
    
    let produceDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        
        return label
    }()
    
    let showTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        
        return label
    }()
    
    let gradeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .medium)
        label.textColor = .black
        
        return label
    }()
    
    let audTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.text = "누적관객  "
        label.textColor = .black
        
        return label
    }()
    
    let audienceLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
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

extension SecondTableViewCellContentView {
    func setupViews() {
        let views = [cellTitleLabel, dateLabel, produceDateLabel, showTimeLabel, genreLabel, gradeLabel, audTitleLabel, audienceLabel]
        views.forEach { self.addSubview($0) }
    }
    
    func setupConstraints() {
        
        NSLayoutConstraint.activate([
            cellTitleLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            cellTitleLabel.topAnchor.constraint(equalTo: self.topAnchor),
        ])
        
        NSLayoutConstraint.activate([
            dateLabel.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 20),
            dateLabel.topAnchor.constraint(equalTo: self.cellTitleLabel.bottomAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            produceDateLabel.leadingAnchor.constraint(equalTo: self.dateLabel.trailingAnchor, constant: 10),
            produceDateLabel.centerYAnchor.constraint(equalTo: self.dateLabel.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            showTimeLabel.leadingAnchor.constraint(equalTo: self.produceDateLabel.trailingAnchor, constant: 10),
            showTimeLabel.centerYAnchor.constraint(equalTo: self.dateLabel.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            genreLabel.leadingAnchor.constraint(equalTo: self.dateLabel.leadingAnchor),
            genreLabel.topAnchor.constraint(equalTo: self.dateLabel.bottomAnchor, constant: 20),
        ])
        
        NSLayoutConstraint.activate([
            gradeLabel.leadingAnchor.constraint(equalTo: self.genreLabel.trailingAnchor, constant: 10),
            gradeLabel.centerYAnchor.constraint(equalTo: self.genreLabel.centerYAnchor),
        ])
        
        NSLayoutConstraint.activate([
            audTitleLabel.leadingAnchor.constraint(equalTo: self.dateLabel.leadingAnchor),
            audTitleLabel.topAnchor.constraint(equalTo: self.genreLabel.bottomAnchor, constant: 20),
            audTitleLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -40)
        ])
        
        NSLayoutConstraint.activate([
            audienceLabel.leadingAnchor.constraint(equalTo: self.audTitleLabel.trailingAnchor, constant: 5),
            audienceLabel.centerYAnchor.constraint(equalTo: self.audTitleLabel.centerYAnchor)
        ])
    }
    
    func bind() {
        didReceiveViewModel = { [weak self] viewModel in
            guard let self = self else { return }
            self.viewModel = viewModel
            
            guard let viewModel = self.viewModel else { return }
            self.dateLabel.text = viewModel.getDateString(viewModel.openDt)
            self.produceDateLabel.text = "|  " + viewModel.getProduceDateString(viewModel.prdtYear)
            self.showTimeLabel.text = "|  " + viewModel.getShowTimeString(viewModel.showTm)
            
            self.genreLabel.text = viewModel.getGenreString(viewModel.genreNm)
            self.gradeLabel.text = "|  " + viewModel.getGradeString(viewModel.watchGradeNm)
            self.audienceLabel.text = viewModel.getAudienceString(viewModel.audiAcc)
        }
    }
}

