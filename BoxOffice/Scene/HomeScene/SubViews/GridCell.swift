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
        imageView.layer.borderWidth = 1
        imageView.layer.borderColor = UIColor.systemGray3.cgColor
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let mainStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .top
        return stackView
    }()
    
    private let infoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.alignment = .leading
        return stackView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 1
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
    
    private let rankBackgroundView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .black
        view.alpha = 0.5
        return view
    }()
    
    private let fakeView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.widthAnchor.constraint(equalToConstant: 10).isActive = true
        view.heightAnchor.constraint(greaterThanOrEqualToConstant: 1).isActive = true
        view.setContentHuggingPriority(.init(100), for: .vertical)
        return view
    }()
    
    private let currentRanklabel = MovieLabel(font: .largeTitle, isBold: true)
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        currentRanklabel.textColor = .white
        addSubViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup(with data: MovieData) {
        titleLabel.text = data.title
        currentRanklabel.text = data.currentRank
        setOpenDateLabel(with: data.openDate)
        setRankChangeLabel(with: data.rankChange)
        setTotalAudiencesCountLabel(with: data.totalAudience)
        setNewEntryBadgeLabel(with: data.isNewEntry)
        setPosterImageView(with: data.poster)
    }
    
    private func setOpenDateLabel(with openDate: String) {
        let characterArray = Array(openDate).map { String($0) }
        let date = characterArray[0...3].joined() + "-" + characterArray[4...5].joined() + "-" + characterArray[6...7].joined() + " 개봉"
        openDateLabel.text = date
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
        totalAudiencesCountLabel.text = "관객수 " + totalAudience.toDecimal() + "명"
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
        mainStackView.addArrangedSubview(posterImageView)
        mainStackView.addArrangedSubview(infoStackView)
        infoStackView.addArrangedSubview(titleLabel)
        infoStackView.addArrangedSubview(badgeStackView)
        badgeStackView.addArrangedSubview(rankChangeBadgeLabel)
        badgeStackView.addArrangedSubview(newEntryBadgeLabel)
        infoStackView.addArrangedSubview(totalAudiencesCountLabel)
        infoStackView.addArrangedSubview(openDateLabel)
        infoStackView.addArrangedSubview(fakeView)
        
        addSubview(rankBackgroundView)
        rankBackgroundView.addSubview(currentRanklabel)
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: topAnchor),
            mainStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            mainStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            
            currentRanklabel.centerXAnchor.constraint(equalTo: rankBackgroundView.centerXAnchor),
            currentRanklabel.centerYAnchor.constraint(equalTo: rankBackgroundView.centerYAnchor),
            
            rankBackgroundView.topAnchor.constraint(equalTo: posterImageView.topAnchor),
            rankBackgroundView.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor),
            rankBackgroundView.widthAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 0.2),
            rankBackgroundView.heightAnchor.constraint(equalTo: rankBackgroundView.widthAnchor),
            
            posterImageView.heightAnchor.constraint(equalTo: heightAnchor, multiplier: 0.7),
            posterImageView.centerXAnchor.constraint(equalTo: centerXAnchor),
        ])
    }
}

extension String {
    var numberFormatter: NumberFormatter {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }
    
    func toDecimal() -> String {
        guard let number = Int(self) else { return "" }
        return numberFormatter.string(from: NSNumber(integerLiteral: number)) ?? ""
    }
}
