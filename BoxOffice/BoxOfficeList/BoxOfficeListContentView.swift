//
//  BoxOfficeListContentView.swift
//  BoxOffice
//
//  Created by YunYoungseo on 2023/01/03.
//

import UIKit

class BoxOfficeListContentView: UIView, UIContentView {
    var configuration: UIContentConfiguration {
        didSet {
            guard let configuration = configuration as? BoxOfficeListContentConfiguration else { return }
            apply(configuration)
        }
    }

    private let rootStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()

    private let lankAndAudienceCountStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        return stackView
    }()

    private let lankStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center

        let footer = UILabel()
        footer.text = "박스오피스"
        footer.textColor = .secondaryLabel
        footer.font = .preferredFont(forTextStyle: .caption1)

        stackView.addArrangedSubview(footer)
        return stackView
    }()

    private let lankTitleStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        return stackView
    }()

    private let audienceCountStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center

        let footer = UILabel()
        footer.text = "당일 관객수"
        footer.textColor = .secondaryLabel
        footer.font = .preferredFont(forTextStyle: .caption1)

        stackView.addArrangedSubview(footer)
        return stackView
    }()

    private let openDateStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center

        let footer = UILabel()
        footer.text = "개봉일"
        footer.textColor = .secondaryLabel
        footer.font = .preferredFont(forTextStyle: .caption1)
        footer.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        stackView.addArrangedSubview(footer)
        return stackView
    }()

    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    private let lankLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    private let openDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    private let audienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    private let rankingChangeLabel: RankingChangeLabel = {
        let label = RankingChangeLabel()
        label.font = .preferredFont(forTextStyle: .subheadline)
        return label
    }()

    init(configuration: BoxOfficeListContentConfiguration) {
        self.configuration = configuration
        super.init(frame: .zero)
        layout()
        apply(configuration)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func layout() {
        lankTitleStackView.addArrangedSubview(lankLabel)
        lankTitleStackView.addArrangedSubview(rankingChangeLabel)

        openDateStackView.insertArrangedSubview(openDateLabel, at: 0)
        audienceCountStackView.insertArrangedSubview(audienceCountLabel, at: 0)
        lankStackView.insertArrangedSubview(lankTitleStackView, at: 0)

        lankAndAudienceCountStackView.addArrangedSubview(openDateStackView)
        lankAndAudienceCountStackView.addArrangedSubview(audienceCountStackView)
        lankAndAudienceCountStackView.addArrangedSubview(lankStackView)

        [
            movieNameLabel,
            lankAndAudienceCountStackView
        ].forEach {
            rootStackView.addArrangedSubview($0)
        }
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rootStackView)
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: topAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5),
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func apply(_ configuration: BoxOfficeListContentConfiguration) {
        if let date = configuration.openDate {
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.formatOptions = .withFullDate
            let dateString = dateFormatter.string(from: date)
            openDateLabel.text = dateString
        }
        movieNameLabel.text = configuration.movieName
        lankLabel.text = "\(configuration.lank ?? 0)위"
        audienceCountLabel.text = configuration.audienceCount?.description
        let rankingChange = configuration.increaseOrDecreaseInRank ?? 0
        let isNewEntryToRank = configuration.isNewEntryToRank ?? false
        rankingChangeLabel.rankingChange = isNewEntryToRank ? .new : .old(change: rankingChange)
    }
}
