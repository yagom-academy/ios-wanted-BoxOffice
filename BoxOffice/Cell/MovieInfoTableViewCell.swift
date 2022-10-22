//
//  MovieInfoTableViewCell.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/19.
//

import UIKit

class MovieInfoTableViewCell: UITableViewCell {
    
    var cellViewModel: MovieInfoCellViewModel? {
        didSet {
            guard let viewModel = cellViewModel else { return }
            openDateLabel.text = viewModel.boxOfficeData.openDt
            rankLabel.text = viewModel.boxOfficeData.rank + " 위"
            movieNameLabel.text = viewModel.cellData.movieNm
            audiAccLabel.text = viewModel.boxOfficeData.audiAcc
            metaDataLabel.text = inputMetaDate(info: viewModel.cellData)
            directorlabel.text = viewModel.directorList()
            actorLabel.text = viewModel.actorList()
            rankIntenLabel.text = inputRankInten(value: viewModel.boxOfficeData.rankInten)
            newLabel.isHidden = true
        }
    }
    
    let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBackground
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
        view.layer.shadowRadius = 10
        view.layer.shadowOpacity = 0.3
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var openDateLabel: UILabel = {
        let view = UILabel()
        view.text = "2000-00-00"
        view.font = .systemFont(ofSize: 14)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let rankLabel: UILabel = {
        let view = UILabel()
        view.text = "#1"
        view.font = .systemFont(ofSize: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let newLabel: UILabel = {
        let view = UILabel()
        view.text = "NEW"
        view.font = .systemFont(ofSize: 18)
        view.textColor = .red
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //전일 대비 순위 증감분
    let rankIntenLabel: UILabel = {
        let view = UILabel()
        view.text = "▲ 1"
        view.textColor = .red
        view.font = .systemFont(ofSize: 18)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let movieNameLabel: UILabel = {
        let view = UILabel()
        view.text = "오징어게임"
        view.font = .boldSystemFont(ofSize: 20)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let audiTitleLabel: UILabel = {
        let view = UILabel()
        view.text = "누적 관객수"
        view.numberOfLines = 0
        view.textAlignment = .center
        view.font = .systemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //누적 관객수
    let audiAccLabel: UILabel = {
        let view = UILabel()
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = "18602751"
        view.font = .systemFont(ofSize: 16)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let metaDataLabel: UILabel = {
        let view = UILabel()
        view.numberOfLines = 0
        view.font = .systemFont(ofSize: 14)
        view.text = "2022 개봉  |  2022 제작  |  2시간 35분  |  SF"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let filmRateLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 14)
        view.text = "12세이상관람가"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var audienceStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [audiTitleLabel, audiAccLabel])
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .horizontal
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let directorTitlelabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.text = "감독"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let directorlabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 12)
        view.text = "차지은"
        view.numberOfLines = 0
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let actorTitleLabel: UILabel = {
        let view = UILabel()
        view.font = .systemFont(ofSize: 12)
        view.text = "배우"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let actorLabel: UILabel = {
        let view = UILabel()
        view.font = .boldSystemFont(ofSize: 12)
        view.numberOfLines = 0
        view.text = "신동원"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
//    let starScoreTitleLabel: UILabel = {
//        let view = UILabel()
//        view.font = .boldSystemFont(ofSize: 12)
//        view.text = "평균별점"
//        view.translatesAutoresizingMaskIntoConstraints = false
//        return view
//    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupConstraints() {
        addSubview(containerView)
        
        [rankLabel,openDateLabel,rankIntenLabel,newLabel,movieNameLabel,audienceStackView,metaDataLabel,filmRateLabel,directorTitlelabel,directorlabel,actorTitleLabel,actorLabel].forEach {
            containerView.addSubview($0)
        }
        
        NSLayoutConstraint.activate([
            
            containerView.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            rankLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 20),
            rankLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            rankIntenLabel.centerYAnchor.constraint(equalTo: rankLabel.centerYAnchor),
            rankIntenLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 8),
            
            newLabel.centerYAnchor.constraint(equalTo: rankIntenLabel.centerYAnchor),
            newLabel.leadingAnchor.constraint(equalTo: rankIntenLabel.trailingAnchor, constant: 8),
            
            openDateLabel.centerYAnchor.constraint(equalTo: rankLabel.centerYAnchor),
            openDateLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            movieNameLabel.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 8),
            movieNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            audienceStackView.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 8),
            audienceStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            metaDataLabel.topAnchor.constraint(equalTo: audienceStackView.bottomAnchor, constant: 32),
            metaDataLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor,constant: 20),
            metaDataLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            filmRateLabel.topAnchor.constraint(equalTo: metaDataLabel.bottomAnchor, constant: 8),
            filmRateLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            directorTitlelabel.topAnchor.constraint(equalTo: filmRateLabel.bottomAnchor, constant: 32),
            directorTitlelabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            
            directorlabel.topAnchor.constraint(equalTo: filmRateLabel.bottomAnchor, constant: 32),
            directorlabel.leadingAnchor.constraint(equalTo: directorTitlelabel.trailingAnchor, constant: 20),
            
            actorTitleLabel.topAnchor.constraint(equalTo: directorTitlelabel.bottomAnchor, constant: 20),
            actorTitleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            actorTitleLabel.trailingAnchor.constraint(greaterThanOrEqualTo: directorTitlelabel.trailingAnchor),
            
            actorLabel.topAnchor.constraint(equalTo: directorTitlelabel.bottomAnchor, constant: 20),
            actorLabel.leadingAnchor.constraint(equalTo: actorTitleLabel.trailingAnchor, constant: 20),
            actorLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            actorLabel.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
            
            
            
        ])
    }
    
    func inputMetaDate(info: MovieInfo) -> String {
        
        var genres: [String] = []
        info.genres.forEach { genre in
            genres.append(genre.genreNm)
        }
        
        let meta = info.openDt.substring(from: 0, to: 3) + " 개봉  |  " + info.prdtYear + "제작  |  " + info.showTm + "분  |  " + genres.joined(separator: ",")
        return meta
    }
    
    func inputRankInten(value: String) -> String {
        guard let rankInten = Int(value)
        else {
            return value
        }
        if rankInten > 0 {
            rankIntenLabel.textColor = .red
            return "▲ +\(rankInten)"
        } else if rankInten < 0 {
            rankIntenLabel.textColor = .blue
            return "▼ \(rankInten)"
        } else {
            rankIntenLabel.textColor = .gray
            return "–"
        }
    }
}
