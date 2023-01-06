//
//  MovieListCollectionViewCell.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/03.
//

import UIKit

final class MovieListCollectionViewCell: UICollectionViewCell {
    static let reuseIdentifier = "movieListCollectionViewCell"

    private let fetchMovieDetailUseCase = FetchMovieDetailUseCase()
    private let fetchPosterImageUseCase = FetchPosterImageUseCase()
    private var fetchMoviePosterTask: Cancellable?
    
    private var movieCode: String?
    private var dayType: DayType?
    private var region: Region?
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.backgroundColor = .systemGray4
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 10
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
        
    private let rankValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        return label
    }()
    
    private let openingDayLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "개봉일"
        label.textColor = Color.valueTitleLabel
        return label
    }()
    
    private let openingDayValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.valueLabel
        return label
    }()
    
    private let audienceNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "관객수"
        label.textColor = Color.valueTitleLabel
        return label
    }()
    
    private let audienceNumberValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.valueLabel
        return label
    }()
        
    private let rankFluctuationValueLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.positiveAccent
        return label
    }()
    
    private let newlyRankedLabel: UILabel = {
       let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = Color.positiveAccent
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addViews()
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
}

extension MovieListCollectionViewCell {
    override func prepareForReuse() {
        super.prepareForReuse()

        fetchMoviePosterTask?.cancel()

        imageView.image = UIImage()
        titleLabel.text = ""
        rankValueLabel.text = ""
        newlyRankedLabel.text = ""
        
        audienceNumberValueLabel.text = ""
        openingDayValueLabel.text = ""
        
        rankFluctuationValueLabel.text = ""
    }
    
    func setupContents(movieOverview: MovieOverview) {
        movieCode = movieOverview.movieCode
        dayType = movieOverview.dayType
        region = movieOverview.region
        
        titleLabel.text = movieOverview.title
        rankValueLabel.text = "\(movieOverview.rank)"
        newlyRankedLabel.text = movieOverview.isNewlyRanked ? "New" : ""
        audienceNumberValueLabel.text = movieOverview.audienceNumber.toStringWithComma()
        openingDayValueLabel.text = movieOverview.openingDay.toStringWithDateFormat()
        
        if movieOverview.rankFluctuation > 0 {
            rankFluctuationValueLabel.text = "▲ \(movieOverview.rankFluctuation)"
            rankFluctuationValueLabel.textColor = Color.positiveAccent
        } else if movieOverview.rankFluctuation < 0 {
            rankFluctuationValueLabel.text = "▼ \(-movieOverview.rankFluctuation)"
            rankFluctuationValueLabel.textColor = Color.negativeAccent
        } else {
            rankFluctuationValueLabel.text = ""
        }

        fetchPosterImage()
    }

    private func fetchPosterImage() {
        guard let movieCode = movieCode else { return }
        fetchMoviePosterTask = fetchMovieDetailUseCase.execute(movieCode: movieCode) { [weak self] result in
            switch result {
            case .success(let movieDetail):
                let englishTitle = movieDetail.englishTitle
                let task = self?.fetchPosterImageUseCase.execute(englishMovieTitle: englishTitle) { result in
                    switch result {
                    case .success(let image):
                        DispatchQueue.main.async {
                            self?.imageView.image = image
                        }
                    case .failure(let error):
                        print(error)
                    }
                }
                task?.resume()
            case .failure(let error):
                print(error)
            }
        }

        fetchMoviePosterTask?.resume()
    }
}

private extension MovieListCollectionViewCell {
    func addViews() {
        [
            imageView,
            titleLabel,
            rankValueLabel,
            openingDayLabel,
            openingDayValueLabel,
            audienceNumberLabel,
            audienceNumberValueLabel,
            rankFluctuationValueLabel,
            newlyRankedLabel
        ].forEach { contentView.addSubview($0) }
    }
    
    func setupLayout() {
        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: Constraint.outerSpacing + Constraint.subtleInnerSpacing),
            imageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -Constraint.outerSpacing),
            imageView.widthAnchor.constraint(equalToConstant: Constraint.imageViewWidth),
            
            rankValueLabel.leadingAnchor.constraint(equalTo: imageView.leadingAnchor, constant: Constraint.innerSpacing),
            rankValueLabel.topAnchor.constraint(equalTo: imageView.topAnchor, constant: Constraint.innerSpacing),

            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: Constraint.innerSpacing + Constraint.subtleInnerSpacing),
            titleLabel.topAnchor.constraint(equalTo: imageView.topAnchor),

            rankFluctuationValueLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            rankFluctuationValueLabel.topAnchor.constraint(greaterThanOrEqualTo: titleLabel.bottomAnchor, constant: Constraint.innerSpacing),
            rankFluctuationValueLabel.bottomAnchor.constraint(equalTo: audienceNumberLabel.topAnchor, constant: -Constraint.innerSpacing),
            
            newlyRankedLabel.leadingAnchor.constraint(equalTo: rankFluctuationValueLabel.trailingAnchor, constant: Constraint.innerSpacing),
            newlyRankedLabel.bottomAnchor.constraint(equalTo: audienceNumberLabel.topAnchor, constant: -Constraint.innerSpacing),
            
            audienceNumberLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            audienceNumberLabel.bottomAnchor.constraint(equalTo: openingDayLabel.topAnchor, constant: -Constraint.innerSpacing),

            audienceNumberValueLabel.leadingAnchor.constraint(equalTo: audienceNumberLabel.trailingAnchor, constant: Constraint.innerSpacing),
            audienceNumberValueLabel.topAnchor.constraint(equalTo: audienceNumberLabel.topAnchor),
            
            openingDayLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            openingDayLabel.bottomAnchor.constraint(equalTo: imageView.bottomAnchor),
            
            openingDayValueLabel.leadingAnchor.constraint(equalTo: openingDayLabel.trailingAnchor, constant: Constraint.innerSpacing),
            openingDayValueLabel.topAnchor.constraint(equalTo: openingDayLabel.topAnchor),
        ])
    }
}

private extension MovieListCollectionViewCell {
    enum Constraint {
        static let innerSpacing: CGFloat = 8
        static let subtleInnerSpacing: CGFloat = 4
        static let outerSpacing: CGFloat = 16
        static let imageViewWidth: CGFloat = 120
        static let imageViewHeight: CGFloat = 160
    }
    
    enum Color {
        static let valueTitleLabel: UIColor = .secondaryLabel
        static let valueLabel: UIColor = .label
        static let positiveAccent: UIColor = .red
        static let negativeAccent: UIColor = .blue
    }
}

fileprivate extension Date {
    func toStringWithDateFormat() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        
        return formatter.string(from: self)
    }
}

fileprivate extension UInt {
    func toStringWithComma() -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        guard let formattedNumber = formatter.string(from: NSNumber(value: self)) else {
            return ""
        }
        
        return formattedNumber
    }
}
