//
//  MovieCell.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/04.
//

import UIKit

class MovieCell: UITableViewCell {
    
    private var viewModel: MovieCellViewModel?
    
    // MARK: - Views
    private lazy var backgroundStackView: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 20)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(top: 8, leading: 20, bottom: 8, trailing: 20)
        stackView.addArrangedSubviews(rankLabel, rankIntenView, movieInfoView, posterView)
        return stackView
    }()
    
    private lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.font = .preferredFont(for: .title2, weight: .bold)
        label.textColor = .label
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var rankIntenView: UIStackView = {
        let stackView = UIStackView(axis: .horizontal, alignment: .center, distribution: .fill, spacing: 2)
        stackView.addArrangedSubviews(arrowImageView, rankIntenLabel)
        stackView.widthAnchor.constraint(equalToConstant: 36).isActive = true
        stackView.setContentHuggingPriority(.required, for: .horizontal)
        return stackView
    }()
    
    private lazy var arrowImageView: UIImageView = {
        let imageView = UIImageView()
        let config = UIImage.SymbolConfiguration(textStyle: .body, scale: .medium)
        imageView.image = UIImage(systemName: "arrowtriangle.up.fill")?.withConfiguration(config)
        imageView.tintColor = .systemRed
        imageView.setContentHuggingPriority(.required, for: .horizontal)
        return imageView
    }()
    
    private lazy var rankIntenLabel: UILabel = {
        let label = UILabel()
        label.text = "2"
        label.font = .preferredFont(for: .body, weight: .regular)
        label.textColor = .label
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private lazy var movieInfoView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 20)
        stackView.addArrangedSubviews(titleLabel, movieOtherView)
        return stackView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.text = "가디언즈 오브 갤럭시 오브 갤럭시"
        label.numberOfLines = 2
        label.font = .preferredFont(for: .body, weight: .semibold)
        label.textColor = .label
        return label
    }()
    
    private lazy var movieOtherView: UIStackView = {
        let stackView = UIStackView(axis: .vertical, alignment: .fill, distribution: .fill, spacing: 2)
        stackView.addArrangedSubviews(openDateLabel, audienceAccumulationLabel)
        return stackView
    }()
    
    private lazy var openDateLabel: UILabel = {
        let label = UILabel()
        label.text = "개봉 2023.01.02"
        label.font = .preferredFont(for: .footnote, weight: .regular)
        label.textColor = .label
        return label
    }()

    private lazy var audienceAccumulationLabel: UILabel = {
        let label = UILabel()
        label.text = "123,456명"
        label.font = .preferredFont(for: .footnote, weight: .regular)
        label.textColor = .label
        label.setContentCompressionResistancePriority(.defaultHigh, for: .vertical)
        return label
    }()
    
    private lazy var posterView: UIImageView = {
        let imageView = UIImageView()
        imageView.widthAnchor.constraint(equalToConstant: 90).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: 110).isActive = true
        imageView.backgroundColor = .darkGray
        return imageView
    }()
    
    // MARK: - override
    override func prepareForReuse() {
        super.prepareForReuse()
        reset()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configure()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    // MARK: - Set up
    func setUp(viewModel: MovieCellViewModel) {
        self.viewModel = viewModel
        setUpViews()
    }
    
}

private extension MovieCell {
    
    func configure() {
        selectionStyle = .none
        contentView.backgroundColor = .boBackground
        contentView.addSubviews(backgroundStackView)
        NSLayoutConstraint.activate([
            backgroundStackView.topAnchor.constraint(equalTo: contentView.topAnchor),
            backgroundStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            backgroundStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            backgroundStackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func setUpViews() {
        rankLabel.text = viewModel?.movie.boxOfficeInfo?.rank.description
        setUpArrowView()
        setUpInfo()
    }
    
    func setUpArrowView() {
        guard let boxOfficeInfo = viewModel?.movie.boxOfficeInfo,
              (boxOfficeInfo.rankInten != 0 || boxOfficeInfo.rankOldAndNew != .old) else {
            rankIntenLabel.text = "-"
            arrowImageView.isHidden = true
            return
        }
        arrowImageView.isHidden = false
        rankIntenLabel.text = boxOfficeInfo.rankInten.description
        let config = UIImage.SymbolConfiguration(textStyle: .body, scale: .medium)
        let upArrow = UIImage(systemName: "arrowtriangle.up.fill")?.withConfiguration(config)
        let downArrow = UIImage(systemName: "arrowtriangle.down.fill")?.withConfiguration(config)
        if boxOfficeInfo.rankOldAndNew == .new {
            arrowImageView.isHidden = true
            rankIntenLabel.text = boxOfficeInfo.rankOldAndNew.rawValue.capitalized
        } else if boxOfficeInfo.rankInten > 0 {
            arrowImageView.image = upArrow
            arrowImageView.tintColor = .systemRed
        } else {
            arrowImageView.image = downArrow
            arrowImageView.tintColor = .systemBlue
        }
    }
    
    func setUpInfo() {
        guard let movie = viewModel?.movie else {
            return
        }
        titleLabel.text = movie.name
        openDateLabel.text = "개봉 \(movie.openDate.toString(.yyyyMMddDot))"
        audienceAccumulationLabel.text = "\(movie.boxOfficeInfo?.audienceAccumulation.numberFormatter() ?? "")명"
        posterView.setImage(with: movie.detailInfo?.poster ?? "")
    }
    
    func reset() {
        ImageCacheManager.shared.cancelDownloadTask()
        rankLabel.text = nil
        rankIntenLabel.text = nil
        arrowImageView.image = nil
        titleLabel.text = nil
        openDateLabel.text = nil
        audienceAccumulationLabel.text = nil
        posterView.image = nil
    }
    
}
