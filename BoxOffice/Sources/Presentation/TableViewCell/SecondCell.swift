//
//  SecondCell.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/03.
//

import UIKit

class SecondCell: UITableViewCell {
    private lazy var rankingattendancestarsStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .horizontal
        stackview.alignment = .center
        stackview.distribution = .equalSpacing
        stackview.spacing = 5
        return stackview
    }()
    
    private lazy var rankingStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fill
        stackview.spacing = 4
        return stackview
    }()
    
    private lazy var rankingLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.text = "1위"
        return label
    }()
    
    private lazy var boxOfficeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textColor = .gray
        label.text = "박스 오피스"
        return label
    }()
    
    private lazy var attendanceStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fill
        stackview.spacing = 4
        return stackview
    }()
    
    private lazy var attendanceLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.text = "123,456"
        return label
    }()
    
    private lazy var cumulativeAudienceLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textColor = .gray
        label.text = "누적 관객수"
        return label
    }()
    
    private lazy var reviewStackView: UIStackView = {
        let stackview = UIStackView()
        stackview.axis = .vertical
        stackview.alignment = .center
        stackview.distribution = .fill
        stackview.spacing = 4
        return stackview
    }()
    
    private lazy var starsLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 25)
        label.textColor = .white
        label.text = "4.1"
        return label
    }()
    
    private lazy var reviewLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.textColor = .gray
        label.text = "리뷰"
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setAutolayout()
        contentView.backgroundColor = .boBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setAutolayout() {
        contentView.addSubviews(rankingattendancestarsStackView)
        
        rankingStackView.addArrangedSubviews(rankingLabel, boxOfficeLabel)
        
        attendanceStackView.addArrangedSubviews(attendanceLabel, cumulativeAudienceLabel)
        
        reviewStackView.addArrangedSubviews(starsLabel, reviewLabel)
        
        rankingattendancestarsStackView.addArrangedSubviews(rankingStackView, attendanceStackView, reviewStackView)
        
        NSLayoutConstraint.activate([
            rankingattendancestarsStackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 16),
            rankingattendancestarsStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 35),
            rankingattendancestarsStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -35),
            rankingattendancestarsStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -16)
        ])
    }
    
    func transferData(_ boxOfficeInfo: BoxOfficeInfo) {
        rankingLabel.text = "\(boxOfficeInfo.rank)위"
        attendanceLabel.text = boxOfficeInfo.audienceAccumulation.numberFormatter()
        starsLabel.text = "구현"
    }
}
