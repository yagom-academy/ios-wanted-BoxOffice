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
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.spacing = 10
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private let movieInfomationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .blue
        return stackView
    }()
    
    private let audienceInfomationStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.backgroundColor = .white
        return stackView
    }()
    
    private let moviewPosterImage: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "avatarposter")
        imageView.contentMode = .scaleToFill
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        return imageView
    }()
    
    private let krTitileLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "아바타: 물의 길"
        return label
    }()
    
    private let engTitileLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Avatar: The Way of Water"
        return label
    }()
    
    private let ageLimitLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "12세이상관람가"
        return label
    }()
    
    private let rankingLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "1위"
        return label
    }()
    
    private let gradeLabel: UILabel = {
        let label = UILabel()
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
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2022.12.14"
        return label
    }()
    
    private let genreLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "SF,스릴러,액션,어드벤쳐"
        return label
    }()
    
    private let directorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "제임스 카메론"
        return label
    }()
    
    private let castLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let runningTimeLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "192 분"
        return label
    }()
    
    private let createdAtLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "2022-12-14"
        return label
    }()
    
    private let audienceLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "22만명"
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
    
    private func commonInit() {
        configureUI()
        setUpBaseUIConstraints()
    }
    
    private func configureUI() {
        self.addSubview(contentScrollView)
        contentScrollView.addSubview(verticalStackView)
        verticalStackView.addArrangedSubview(moviewPosterImage)
        verticalStackView.addArrangedSubview(descriptionLabel)
        movieInfomationStackView.addArrangedSubview(releaseLabel)
        movieInfomationStackView.addArrangedSubview(genreLabel)
        movieInfomationStackView.addArrangedSubview(ageLimitLabel)
        movieInfomationStackView.addArrangedSubview(directorLabel)
        movieInfomationStackView.addArrangedSubview(castLabel)
        movieInfomationStackView.addArrangedSubview(runningTimeLabel)
        movieInfomationStackView.addArrangedSubview(createdAtLabel)
        verticalStackView.addArrangedSubview(movieInfomationStackView)
        audienceInfomationStackView.addArrangedSubview(audienceLabel)
        verticalStackView.addArrangedSubview(audienceLabel)
        
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
            self.verticalStackView.widthAnchor.constraint(equalTo: self.widthAnchor),
            
            self.moviewPosterImage.topAnchor.constraint(equalTo: verticalStackView.topAnchor),
            self.moviewPosterImage.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor),
            self.moviewPosterImage.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor),
            self.moviewPosterImage.heightAnchor.constraint(equalTo: moviewPosterImage.widthAnchor),

            self.descriptionLabel.leadingAnchor.constraint(equalTo: verticalStackView.leadingAnchor, constant: 10),
            self.descriptionLabel.trailingAnchor.constraint(equalTo: verticalStackView.trailingAnchor, constant: -10),

            self.movieInfomationStackView.leadingAnchor.constraint(equalTo: self.verticalStackView.leadingAnchor),
            self.movieInfomationStackView.trailingAnchor.constraint(equalTo: self.verticalStackView.trailingAnchor),

//            self.audienceInfomationStackView.topAnchor.constraint(equalTo: self.movieInfomationStackView.bottomAnchor),
//            self.audienceInfomationStackView.leadingAnchor.constraint(equalTo: self.movieInfomationStackView.leadingAnchor),
//            self.audienceInfomationStackView.trailingAnchor.constraint(equalTo: self.movieInfomationStackView.trailingAnchor),
//            self.audienceInfomationStackView.widthAnchor.constraint(equalTo: self.movieInfomationStackView.widthAnchor),
            
        ])
    }
}
