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
        stackView.distribution = .fillProportionally
        return stackView
    }()

    private let lankStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    private let audienceCountStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    private let openDateStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .leading
        stackView.spacing = 5.0

        let header = UILabel()
        header.text = "개봉일"
        header.textColor = .secondaryLabel
        header.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        stackView.addArrangedSubview(header)
        return stackView
    }()

    private let rankChangeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        return stackView
    }()

    private let movieNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .largeTitle)
        return label
    }()
    private let lankLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .headline)
        return label
    }()
    private let openDateLabel = UILabel()
    private let audienceCountLabel = UILabel()
    private let increaseOrDecreaseInRankLabel = UILabel()
    private let isNewEntryToRankLabel = UILabel()

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
        let audienceCountCaption = UILabel()
        audienceCountCaption.text = "당일 관객수"
        audienceCountCaption.font = .preferredFont(forTextStyle: .headline)
        audienceCountStackView.addArrangedSubview(audienceCountLabel)
        audienceCountStackView.addArrangedSubview(audienceCountCaption)

        let lankCaption = UILabel()
        lankCaption.text = "박스오피스"
        lankCaption.font = .preferredFont(forTextStyle: .caption1)
        lankStackView.addArrangedSubview(lankLabel)
        lankStackView.addArrangedSubview(lankCaption)

        increaseOrDecreaseInRankLabel.font = .preferredFont(forTextStyle: .largeTitle)
        isNewEntryToRankLabel.font = .preferredFont(forTextStyle: .caption1)
        rankChangeStackView.addArrangedSubview(increaseOrDecreaseInRankLabel)
        rankChangeStackView.addArrangedSubview(isNewEntryToRankLabel)

        lankAndAudienceCountStackView.addArrangedSubview(audienceCountStackView)
        lankAndAudienceCountStackView.addArrangedSubview(lankStackView)
        lankAndAudienceCountStackView.addArrangedSubview(rankChangeStackView)
        openDateStackView.addArrangedSubview(openDateLabel)

        let countStack = UIStackView()
        countStack.axis = .horizontal


        [
            movieNameLabel,
            lankAndAudienceCountStackView,
            openDateStackView
        ].forEach {
            rootStackView.addArrangedSubview($0)
        }
        rootStackView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(rootStackView)
        NSLayoutConstraint.activate([
            rootStackView.topAnchor.constraint(equalTo: topAnchor),
            rootStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
            rootStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            rootStackView.trailingAnchor.constraint(equalTo: trailingAnchor)
        ])
    }

    private func apply(_ configuration: BoxOfficeListContentConfiguration) {
        if let date = configuration.openDate {
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .long
            dateFormatter.timeStyle = .none
            let dateString = dateFormatter.string(from: date)
            openDateLabel.text = dateString
        }
        movieNameLabel.text = configuration.movieName
        lankLabel.text = "\(configuration.lank ?? 0)위"
        audienceCountLabel.text = configuration.audienceCount?.description
        increaseOrDecreaseInRankLabel.text = configuration.increaseOrDecreaseInRank?.description
        guard let isNewEntryToRank = configuration.isNewEntryToRank else { return }
        isNewEntryToRankLabel.text = isNewEntryToRank ? "New" : "Old"
    }
}
