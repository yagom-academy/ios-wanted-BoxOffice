//
//  secondView.swift
//  BoxOffice
//
//  Created by 백곰 on 2023/01/02.
//

import Foundation
import UIKit

final class MovieDetailView: UIView {
    
    // MARK: Properties
    
    private let contentScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.backgroundColor = .white
        return scrollView
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private let movieInfomationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .black
        stackView.spacing = 5
        return stackView
    }()
    
    private let audienceInfomationStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let stackAudienceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .black
        stackView.spacing = 5
        return stackView
    }()
    
    private let dailyAudienceStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .black
        stackView.spacing = 5
        return stackView
    }()
    
    private let boxOfficeRankStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .black
        return stackView
    }()
    
    private let boxOfficeIncreaseRankStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .black
        return stackView
    }()
    
    private let boxOfficeNewRankStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .top
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .black
        return stackView
    }()
    
    private let moviewPosterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let krTitileLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let engTitileLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let ageLimitLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rankingLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let gradeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let releaseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let typeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakStrategy = .hangulWordPriority
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let castLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.lineBreakStrategy = .hangulWordPriority
        label.lineBreakMode = .byCharWrapping
        label.numberOfLines = 0
        return label
    }()
    
    
    private let createdAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let openAtLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .white
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stackAudienceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "누적 관객 수"
        return label
    }()
    
    private let stackAudienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let dailyAudienceLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.textColor = .lightGray
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "일별 관객 수"
        return label
    }()
    
    private let dailyAudienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let boxOfficeRankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "순위"
        return label
    }()
    
    private let boxOfficeRankNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let rankIncreaseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "증감분"
        return label
    }()
    
    private let rankIncreaseNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let newRankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "신규여부"
        return label
    }()
    
    private let newRankJudgeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: - Initializers
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }
    
    
    // MARK: - Methods
    
    private func refineDate(date: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let convertDate = dateFormatter.date(from: date)
        
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let result = dateFormatter.string(from: convertDate!)
        return result
    }
    
    func fetchMovieDetailData(posterData: MoviePosterInfo?, movieData: MovieDetailInfo?,
                              boxOfficeData: BoxOffice) {
        guard let posterData = posterData else { return }
        guard let movieData = movieData else { return }
        
        var movieType = movieData.movieInfoResult.movieInfo.showTypes[0].showTypeNm
        let movieTypeArray = movieData.movieInfoResult.movieInfo.showTypes
        for TypeCount in 1..<movieData.movieInfoResult.movieInfo.showTypes.count {
            movieType += "," + movieTypeArray[TypeCount].showTypeNm
        }
        
        var moviegenres = movieData.movieInfoResult.movieInfo.genres[0].genreNm
        let moviegenresArray = movieData.movieInfoResult.movieInfo.genres
        for genresCount in 1..<movieData.movieInfoResult.movieInfo.genres.count {
            moviegenres += "," + moviegenresArray[genresCount].genreNm
        }
        
        var movieActors = "없음"
        
        if !movieData.movieInfoResult.movieInfo.actors.isEmpty {
            movieActors = ""
            movieActors = movieData.movieInfoResult.movieInfo.actors[0].peopleNm
            let movieActorsArray = movieData.movieInfoResult.movieInfo.actors
            for actorsCount in 1..<movieData.movieInfoResult.movieInfo.actors.count {
                movieActors += "," + movieActorsArray[actorsCount].peopleNm
            }
        }
        
        let dateFormatter = ISO8601DateFormatter()
        dateFormatter.formatOptions = .withFullDate
        dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
        let dateString = dateFormatter.string(from: boxOfficeData.openDate)
       
        
        let url = URL(string: posterData.search[0].poster)
        moviewPosterImage.load(url: url!)
        
        krTitileLabel.text = "제목: " + movieData.movieInfoResult.movieInfo.movieNm
        releaseLabel.text = "개봉일: " + dateString
        createdAtLabel.text = "제작년도: " + movieData.movieInfoResult.movieInfo.prdtYear
        openAtLabel.text = "개봉년도: " + refineDate(date:movieData.movieInfoResult.movieInfo.openDt)
        typeLabel.text = "타입: " + movieType
        genreLabel.text = "장르: " + moviegenres + " /" + movieData.movieInfoResult.movieInfo.showTm + " 분"
        ageLimitLabel.text = "등급: " + movieData.movieInfoResult.movieInfo.audits[0].watchGradeNm
        directorLabel.text = "감독: " + movieData.movieInfoResult.movieInfo.directors[0].peopleNm
        castLabel.text = "출연: " + movieActors
        stackAudienceCountLabel.text = String(boxOfficeData.audiAcc) + "명"
        dailyAudienceCountLabel.text = String(boxOfficeData.audiCnt) + "명"
        boxOfficeRankNumberLabel.text = String(boxOfficeData.rank) + "위"
        rankIncreaseNumberLabel.text = String(boxOfficeData.audiInten)
        newRankJudgeLabel.text = boxOfficeData.isNewRanked == true ? "New" : "Old"
    }
    
    private func commonInit() {
        configureUI()
        setUpBaseUIConstraints()
    }
    
    private func configureUI() {
        self.addSubview(contentScrollView)
        contentScrollView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(moviewPosterImage)
        
        movieInfomationStackView.addArrangedSubview(krTitileLabel)
        movieInfomationStackView.addArrangedSubview(releaseLabel)
        movieInfomationStackView.addArrangedSubview(createdAtLabel)
        movieInfomationStackView.addArrangedSubview(openAtLabel)
        movieInfomationStackView.addArrangedSubview(typeLabel)
        movieInfomationStackView.addArrangedSubview(genreLabel)
        movieInfomationStackView.addArrangedSubview(ageLimitLabel)
        movieInfomationStackView.addArrangedSubview(directorLabel)
        movieInfomationStackView.addArrangedSubview(castLabel)
        
        verticalStackView.addArrangedSubview(movieInfomationStackView)
        
        audienceInfomationStackView.addArrangedSubview(stackAudienceStackView)
        stackAudienceStackView.addArrangedSubview(stackAudienceLabel)
        stackAudienceStackView.addArrangedSubview(stackAudienceCountLabel)
        
        audienceInfomationStackView.addArrangedSubview(dailyAudienceStackView)
        dailyAudienceStackView.addArrangedSubview(dailyAudienceLabel)
        dailyAudienceStackView.addArrangedSubview(dailyAudienceCountLabel)
        verticalStackView.addArrangedSubview(audienceInfomationStackView)
        
        boxOfficeRankStackView.addArrangedSubview(boxOfficeRankLabel)
        boxOfficeRankStackView.addArrangedSubview(boxOfficeRankNumberLabel)
        verticalStackView.addArrangedSubview(boxOfficeRankStackView)
        
        boxOfficeIncreaseRankStackView.addArrangedSubview(rankIncreaseLabel)
        boxOfficeIncreaseRankStackView.addArrangedSubview(rankIncreaseNumberLabel)
        verticalStackView.addArrangedSubview(boxOfficeIncreaseRankStackView)
        
        boxOfficeNewRankStackView.addArrangedSubview(newRankLabel)
        boxOfficeNewRankStackView.addArrangedSubview(newRankJudgeLabel)
        verticalStackView.addArrangedSubview(boxOfficeNewRankStackView)
        
        contentScrollView.insetsLayoutMarginsFromSafeArea = false
        verticalStackView.insetsLayoutMarginsFromSafeArea = false
        contentScrollView.contentInsetAdjustmentBehavior = .never
        
    }
    
    private func setUpBaseUIConstraints() {
        NSLayoutConstraint.activate([
            self.contentScrollView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            self.contentScrollView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            self.contentScrollView.topAnchor.constraint(equalTo: self.topAnchor),
            self.contentScrollView.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            
            self.verticalStackView.leadingAnchor.constraint(equalTo: contentScrollView.leadingAnchor),
            self.verticalStackView.trailingAnchor.constraint(equalTo: contentScrollView.trailingAnchor),
            self.verticalStackView.topAnchor.constraint(equalTo: contentScrollView.topAnchor),
            self.verticalStackView.bottomAnchor.constraint(equalTo: contentScrollView.bottomAnchor),
            self.verticalStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            self.moviewPosterImage.topAnchor.constraint(equalTo: verticalStackView.topAnchor),
            self.moviewPosterImage.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            self.moviewPosterImage.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            self.moviewPosterImage.heightAnchor.constraint(equalTo: moviewPosterImage.widthAnchor),


            self.movieInfomationStackView.topAnchor.constraint(equalTo: moviewPosterImage.bottomAnchor),
            self.movieInfomationStackView.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor),
            self.movieInfomationStackView.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor),
            self.movieInfomationStackView.heightAnchor.constraint(equalTo: self.moviewPosterImage.heightAnchor),

            self.audienceInfomationStackView.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor),
            self.boxOfficeRankStackView.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor),
            self.boxOfficeIncreaseRankStackView.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor),
            self.boxOfficeNewRankStackView.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor),

        ])
    }
}
