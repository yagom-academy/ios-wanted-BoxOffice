//
//  MovieDetailView.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/02.
//

import UIKit

class MovieDetailView: UIView {
    // MARK: properties
    let posterView: UIView = {
        let view = UIView()
        view.layer.borderWidth = 1
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let ageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3, compatibleWith: .none)
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 20)
        label.numberOfLines = 2
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .none)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let runtimeLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .none)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingNameLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .none)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout, compatibleWith: .none)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 10
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.setContentCompressionResistancePriority(
            .required,
            for: .vertical
        )
        stackView.setContentHuggingPriority(
            .required,
            for: .vertical
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let starAverageTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.text = "관람객 평점"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starAverageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let starAverageStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let movieRankIntenLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieRankLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let rankStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let movieAudienceTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .caption2)
        label.text = "누적 관객수"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let movieAudienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let audienceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let blackStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.backgroundColor = .systemGray
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 20,
            leading: 30,
            bottom: 20,
            trailing: 30
        )
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    let productionYearLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .callout)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    let directorAndActorNameTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "감독 및 출연"
        label.font = .boldSystemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let directorAndActorNameStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 10
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let directorAndActorNameScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()

    let MiddleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.spacing = 15
        stackView.axis = .vertical
        stackView.setContentCompressionResistancePriority(
            .defaultLow,
            for: .vertical
        )
        stackView.setContentHuggingPriority(
            .defaultLow,
            for: .vertical
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let shareButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        button.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let reviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("리뷰 작성하기", for: .normal)
        button.backgroundColor = .systemBlue
        button.tintColor = .white
        button.layer.cornerRadius = 10
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    let shareAndReviewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.directionalLayoutMargins = NSDirectionalEdgeInsets(
            top: 20,
            leading: 30,
            bottom: 20,
            trailing: 30
        )
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let reviewTableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 150
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()

    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        self.backgroundColor = .white

        configureView()
        configureUI()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: private function
    private func getGenres(_ data: [Genre]) -> String {
        return data.map { $0.genreNm }.joined(separator: ",")
    }

    private func configureView() {
        self.addSubview(topStackView)
        self.addSubview(blackStackView)
        self.addSubview(MiddleStackView)
        self.addSubview(shareAndReviewStackView)
        self.addSubview(reviewTableView)
        
        topStackView.addArrangedSubview(posterView)
        topStackView.addArrangedSubview(labelStackView)
        
        posterView.addSubview(ageLabel)
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(genreLabel)
        labelStackView.addArrangedSubview(runtimeLabel)
        labelStackView.addArrangedSubview(ratingNameLabel)
        labelStackView.addArrangedSubview(releaseDateLabel)
        
        blackStackView.addArrangedSubview(starAverageStackView)
        blackStackView.addArrangedSubview(rankStackView)
        blackStackView.addArrangedSubview(audienceStackView)
        
        starAverageStackView.addArrangedSubview(starAverageTitleLabel)
        starAverageStackView.addArrangedSubview(starAverageLabel)
        
        rankStackView.addArrangedSubview(movieRankIntenLabel)
        rankStackView.addArrangedSubview(movieRankLabel)
        
        audienceStackView.addArrangedSubview(movieAudienceTitleLabel)
        audienceStackView.addArrangedSubview(movieAudienceCountLabel)

        MiddleStackView.addArrangedSubview(productionYearLabel)
        MiddleStackView.addArrangedSubview(directorAndActorNameTitleLabel)
        MiddleStackView.addArrangedSubview(directorAndActorNameScrollView)
        
        directorAndActorNameScrollView.addSubview(directorAndActorNameStackView)
        
        shareAndReviewStackView.addArrangedSubview(shareButton)
        shareAndReviewStackView.addArrangedSubview(reviewButton)
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(
                equalTo: self.topAnchor,
                constant: 20
            ),
            topStackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -20
            ),
            topStackView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 10
            ),
            
            posterView.widthAnchor.constraint(
                equalTo: topStackView.widthAnchor,
                multiplier: 0.35
            ),
            
            ageLabel.topAnchor.constraint(
                equalTo: posterView.topAnchor,
                constant: 3
            ),
            ageLabel.trailingAnchor.constraint(
                equalTo: posterView.trailingAnchor,
                constant: -3
            ),
            
            blackStackView.topAnchor.constraint(
                equalTo: topStackView.bottomAnchor,
                constant: 10
            ),
            blackStackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor
            ),
            blackStackView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor
            ),

            MiddleStackView.topAnchor.constraint(
                equalTo: blackStackView.bottomAnchor,
                constant: 10
            ),
            MiddleStackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -20
            ),
            MiddleStackView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 20
            ),
            
            directorAndActorNameScrollView.heightAnchor.constraint(
                equalToConstant: 50
            ),
            
            directorAndActorNameStackView.leadingAnchor.constraint(
                equalTo: directorAndActorNameScrollView.contentLayoutGuide.leadingAnchor
            ),
            directorAndActorNameStackView.trailingAnchor.constraint(
                equalTo: directorAndActorNameScrollView.contentLayoutGuide.trailingAnchor
            ),
            directorAndActorNameStackView.topAnchor.constraint(
                equalTo: directorAndActorNameScrollView.contentLayoutGuide.topAnchor
            ),
            directorAndActorNameStackView.bottomAnchor.constraint(
                equalTo: directorAndActorNameScrollView.contentLayoutGuide.bottomAnchor
            ),
            
            shareAndReviewStackView.topAnchor.constraint(
                equalTo: MiddleStackView.bottomAnchor,
                constant: 10
            ),
            shareAndReviewStackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -20
            ),
            shareAndReviewStackView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 20
            ),
            
            reviewTableView.topAnchor.constraint(
                equalTo: shareAndReviewStackView.bottomAnchor,
                constant: 10
            ),
            reviewTableView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -20
            ),
            reviewTableView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 20
            ),
            
            reviewTableView.bottomAnchor.constraint(
                equalTo: self.bottomAnchor,
                constant: -20
            )
        ])
    }
    
    // MARK: function
    func setLabelText(_ data: MovieModel) {
        titleLabel.text = data.boxOfficeInfo.movieNm
        genreLabel.text = getGenres(data.movieInfo.genres)
        runtimeLabel.text = (data.movieInfo.showTm + " 분")
        ratingNameLabel.text = data.movieInfo.audits.first?.watchGradeNm
        releaseDateLabel.text = data.boxOfficeInfo.openDt
        movieAudienceCountLabel.text = data.boxOfficeInfo.audiAcc
        releaseDateLabel.text = (data.boxOfficeInfo.openDt + " 개봉")

        movieRankIntenLabel.text = (
            "전일 대비 " +
            data.boxOfficeInfo.rankInten +
            " (\(data.boxOfficeInfo.rankOldAndNew))"
        )
        
        movieRankLabel.text = (
            "예매율 \(data.boxOfficeInfo.rank)위"
        )
        
        movieAudienceCountLabel.text = (
            "\(String(describing: NumberFormatterManager.shared.getAudience(from: data.boxOfficeInfo.audiAcc)!)) 명"
        )
        
        productionYearLabel.text = (
            "🎞️ \(data.movieInfo.prdtYear)년 제작"
        )
    }

    func addDirectorAndActorLabel(name: String, role: String) {
        let nameLabel: UILabel = {
            let label = UILabel()
            label.text = name
            label.font = .preferredFont(forTextStyle: .callout)
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        let roleLabel: UILabel = {
            let label = UILabel()
            label.text = role
            label.font = .preferredFont(forTextStyle: .caption2)
            label.textColor = .systemGray
            label.translatesAutoresizingMaskIntoConstraints = false
            return label
        }()
        
        if role == "감독" {
            nameLabel.textColor = .brown
        }
        
        let stackView: UIStackView = {
           let stackView = UIStackView()
            stackView.alignment = .top
            stackView.distribution = .fillEqually
            stackView.axis = .vertical
            stackView.translatesAutoresizingMaskIntoConstraints = false
            return stackView
        }()
        
        
        stackView.addArrangedSubview(nameLabel)
        stackView.addArrangedSubview(roleLabel)

        directorAndActorNameStackView.addArrangedSubview(stackView)
    }
    
    func setPoster(image: UIImage, age: String, color: UIColor) {
        var image = image
        image = image.resize(
            newWidth: UIScreen.main.bounds.width/UIScreen.main.scale
        )
        posterView.backgroundColor = UIColor(patternImage: image)
        ageLabel.text = age
        ageLabel.backgroundColor = color
    
        NSLayoutConstraint.activate([
            posterView.heightAnchor.constraint(
                equalToConstant: image.size.height
            )
        ])
    }
}
