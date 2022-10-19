//
//  BoxOfficeTableViewCell.swift
//  BoxOffice
//
//  Created by 신동원 on 2022/10/18.
//

import UIKit

class BoxOfficeTableViewCell: UITableViewCell {
    
    var cellViewModel: BoxOfficeCellViewModel? {
        didSet {
            guard let viewModel = cellViewModel else { return }
            openDateLabel.text = viewModel.cellData.openDt
            rankLabel.text = viewModel.cellData.rank
            movieNameLabel.text = viewModel.cellData.movieNm
            audiAccLabel.text = viewModel.cellData.audiAcc
            posterView.setImageUrl(viewModel.posterURL)
            if viewModel.cellData.rankOldAndNew == .new {
                rankIntenLabel.textColor = .red
                rankIntenLabel.text = RankOldAndNew.new.rawValue
            } else {
                rankIntenLabel.text = inputRankInten(value: viewModel.cellData.rankInten)
            }
        }
    }
    
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
        view.font = .systemFont(ofSize: 24)
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
    
    let posterView: UIImageView = {
        let view = UIImageView()
        view.layer.cornerRadius = 10
        view.image = UIImage(named: "Image")
        view.clipsToBounds = true
        view.contentMode = .scaleAspectFill
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
    
    let audiTitleLabel: PaddingLabel = {
        let view = PaddingLabel(padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        view.text = "누적 관객수"
        view.numberOfLines = 0
        view.textAlignment = .center
        view.textColor = .white
        view.font = .systemFont(ofSize: 18)
        view.backgroundColor = UIColor(named: "customPurple")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    //누적 관객수
    let audiAccLabel: PaddingLabel = {
        let view = PaddingLabel(padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
        view.textAlignment = .center
        view.numberOfLines = 0
        view.text = "18602751"
        view.font = .systemFont(ofSize: 22)
        view.textColor = .white
        view.backgroundColor = .lightGray
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var audienceStackView: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [audiTitleLabel, audiAccLabel])
        stack.layer.masksToBounds = true
        stack.layer.cornerRadius = 10
        stack.alignment = .fill
        stack.distribution = .fill
        stack.axis = .vertical
        stack.backgroundColor = .blue
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    let detailButton: UILabel = {
        let view = UILabel()
        view.text = "자세히보기 ⇨"
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //self.selectionStyle = .none
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupConstraints() {
        selectionStyle = .none
        addSubview(openDateLabel)
        addSubview(rankLabel)
        addSubview(rankIntenLabel)
        addSubview(containerView)
        containerView.addSubview(posterView)
        containerView.addSubview(movieNameLabel)
        containerView.addSubview(audienceStackView)
        containerView.addSubview(detailButton)
        NSLayoutConstraint.activate([
            
            openDateLabel.topAnchor.constraint(equalTo: topAnchor),
            openDateLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            openDateLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor),
            
            rankLabel.topAnchor.constraint(equalTo: openDateLabel.bottomAnchor, constant: 8),
            rankLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            //rankLabel.trailingAnchor.constraint(greaterThanOrEqualTo: trailingAnchor),
            
            rankIntenLabel.bottomAnchor.constraint(equalTo: rankLabel.firstBaselineAnchor),
            rankIntenLabel.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 8),
            
            containerView.topAnchor.constraint(equalTo: rankLabel.bottomAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            containerView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            containerView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            posterView.topAnchor.constraint(equalTo: containerView.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 0.666),

            movieNameLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 20),
            movieNameLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            movieNameLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            
            audienceStackView.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 20),
            audienceStackView.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 20),
            //audienceStackView.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            audienceStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20),
            
            detailButton.topAnchor.constraint(equalTo: movieNameLabel.bottomAnchor, constant: 20),
            detailButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -20),
            audienceStackView.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -20)
            
            
        ])
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
