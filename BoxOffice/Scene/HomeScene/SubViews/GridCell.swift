//
//  GridCell.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/05.
//

import UIKit

final class GridCell: UICollectionViewCell {
    
    private let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        imageView.tintColor = .systemGray3
        
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        stackView.alignment = .top

        stackView.spacing = 10
        return stackView
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 3
        return stackView
    }()
    
    private let rankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        label.setContentHuggingPriority(UILayoutPriority(100), for: .vertical)
        return label
    }()
    
    private let badgeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .horizontal
        stackView.spacing = 5
        return stackView
    }()
    
    private let rankChangeBadgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.layer.backgroundColor = UIColor.systemGreen.cgColor
        label.layer.cornerRadius = 5
        return label
    }()
    
    private let newEntryBadgeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.preferredFont(forTextStyle: .footnote)
        label.layer.backgroundColor = UIColor.systemYellow.cgColor
        label.layer.cornerRadius = 5
        return label
    }()
    
    private let totalAudiencesCountLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        return label
    }()
    
    private let openDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .systemGray
        label.font = UIFont.preferredFont(forTextStyle: .callout)
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.borderWidth = 1
        layer.borderColor = UIColor.systemGray3.cgColor
        layer.cornerRadius = 10
        addSubViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with data: MovieData) {
        titleLabel.text = data.title
        rankLabel.text = data.currentRank
        openDateLabel.text = data.openDate + " 개봉"
        
        setRankChangeLabel(with: data.rankChange)
        setTotalAudiencesCountLabel(with: data.totalAudience)
        setNewEntryBadgeLabel(with: data.isNewEntry)
        setPosterImageView(with: data.poster)
    }
    
    private func setRankChangeLabel(with rankChange: String) {
        if Int(rankChange) ?? 0 > 0 {
            rankChangeBadgeLabel.text = "  " + rankChange + "▲" + "  "
            rankChangeBadgeLabel.layer.backgroundColor = UIColor.systemGreen.cgColor
        } else if Int(rankChange) ?? 0 < 0 {
            rankChangeBadgeLabel.text = "  " + rankChange + "▼" + "  "
            rankChangeBadgeLabel.layer.backgroundColor = UIColor.systemRed.cgColor
        } else {
            rankChangeBadgeLabel.isHidden = true
        }
    }
    
    private func setNewEntryBadgeLabel(with isNewEntry: Bool) {
        if isNewEntry {
            newEntryBadgeLabel.text = " 신규진입 "
        } else {
            newEntryBadgeLabel.text = ""
        }
    }
    
    private func setTotalAudiencesCountLabel(with totalAudience: String) {
        totalAudiencesCountLabel.text = "관객수 " + totalAudience + "명"
    }
    
    private func setPosterImageView(with image: UIImage?) {
        if let image = image {
            posterImageView.image = image
        } else {
            let image = UIImage(systemName: "nosign")
            posterImageView.backgroundColor = .systemGray6
            posterImageView.image = image
        }
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        rankChangeBadgeLabel.isHidden = false
        posterImageView.image = UIImage(systemName: "nosign")
        posterImageView.backgroundColor = nil
    }
}

// MARK: Setup Layout
private extension GridCell {
    func addSubViews() {
        addSubview(mainStackView)
        addSubview(rankLabel)
        mainStackView.addArrangedSubview(posterImageView)
        mainStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(badgeStackView)
        badgeStackView.addArrangedSubview(rankChangeBadgeLabel)
        badgeStackView.addArrangedSubview(newEntryBadgeLabel)
        infoStackView.addArrangedSubview(totalAudiencesCountLabel)
        infoStackView.addArrangedSubview(openDateLabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            rankLabel.topAnchor.constraint(equalTo: topAnchor),
            rankLabel.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            posterImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.6),
            posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

