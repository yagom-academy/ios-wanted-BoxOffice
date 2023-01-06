//
//  secondView.swift
//  BoxOffice
//
//  Created by 백곰 on 2023/01/02.
//

import Foundation
import UIKit

final class SecondView: UIView {
    
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
        label.text = "1위"
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
    
    private let descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title3)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .left
        label.numberOfLines = 0
        label.lineBreakStrategy = .hangulWordPriority
        label.lineBreakMode = .byCharWrapping
        label.adjustsFontForContentSizeCategory = true
        label.text = "작중 배경은 전작의 2154년에서 15년이 지난 2169년이며, 족장이 된 제이크 설리와 네이티리는 가정을 꾸리고 네 자녀를 갖는다. 개중에는 그레이스 박사의 아바타가 낳은 입양아인 키리도 있다. 나이가 어려 냉동 수면을 할 수 없었던 인간 아이 스파이더도 남아 완전히 부족에 동화된 모습이고, 제이크와 함께 남은 과학자 일행도 나비족과 어울리며 잘 정착한 모습이다. 그렇게 평화로운 나날을 보내던 어느날 밤, RDA가 ISV 매니페스트 데스티니를 선두로 한 10척에 이르는 함대를 이끌고 다시 판도라를 침략한다. 이번에는 언옵타늄을 비롯한 자원 채굴이 아니라 죽어가는 지구를 버리고 판도라로의 완전 이주가 목적이었다. 그 일환으로 이들은 판도라에 도시형 기지 브리지헤드를 1년 만에 건설한다."
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
        label.text = "809.4 만"
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
        label.text = "91,102"
        return label
    }()
    
    private let boxOfficeRankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "순위: "
        return label
    }()
    
    private let boxOfficeRankNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1위"
        return label
    }()
    
    private let rankIncreaseLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "증감률: "
        return label
    }()
    
    private let rankIncreaseNumberLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "-0.6%"
        return label
    }()
    
    private let newRankLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "신규여부: "
        return label
    }()
    
    private let newRankJudgeLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.preferredFont(forTextStyle: .title2)
        label.textColor = .white
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "New"
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
        
        dateFormatter.dateFormat = "yyyy.MM.dd"
        let result = dateFormatter.string(from: convertDate!)
        return result
    }
    
    func fetchMovieDetailData(posterData: MoviePosterInfo?, movieData: MovieDetailInfo? ) {
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
        
        var movieActors = movieData.movieInfoResult.movieInfo.actors[0].peopleNm
        let movieActorsArray = movieData.movieInfoResult.movieInfo.actors
        for actorsCount in 1..<movieData.movieInfoResult.movieInfo.actors.count {
            movieActors += "," + movieActorsArray[actorsCount].peopleNm
        }
        
        let url = URL(string: posterData.search[0].poster)
        moviewPosterImage.load(url: url!)
        
        krTitileLabel.text = "제목: " + movieData.movieInfoResult.movieInfo.movieNm
        releaseLabel.text = "개봉일: " + refineDate(date:movieData.movieInfoResult.movieInfo.openDt)
        typeLabel.text = "타입: " + movieType
        genreLabel.text = "장르: " + moviegenres + " /" + movieData.movieInfoResult.movieInfo.showTm + " 분"
        ageLimitLabel.text = "등급: " + movieData.movieInfoResult.movieInfo.audits[0].watchGradeNm
        directorLabel.text = "감독: " + movieData.movieInfoResult.movieInfo.directors[0].peopleNm
        castLabel.text = "출연: " + movieActors
        
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
        movieInfomationStackView.addArrangedSubview(typeLabel)
        movieInfomationStackView.addArrangedSubview(genreLabel)
        movieInfomationStackView.addArrangedSubview(ageLimitLabel)
        movieInfomationStackView.addArrangedSubview(directorLabel)
        movieInfomationStackView.addArrangedSubview(castLabel)
        movieInfomationStackView.addArrangedSubview(createdAtLabel)
        
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

//            self.audienceInfomationStackView.topAnchor.constraint(equalTo: self.movieInfomationStackView.bottomAnchor),
//            self.audienceInfomationStackView.leadingAnchor.constraint(equalTo: self.movieInfomationStackView.leadingAnchor),
//            self.audienceInfomationStackView.trailingAnchor.constraint(equalTo:self.movieInfomationStackView.trailingAnchor),
            self.audienceInfomationStackView.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor),
            self.boxOfficeRankStackView.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor),
            self.boxOfficeIncreaseRankStackView.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor),
            self.boxOfficeNewRankStackView.widthAnchor.constraint(equalTo: self.verticalStackView.widthAnchor),

        ])
    }
}
