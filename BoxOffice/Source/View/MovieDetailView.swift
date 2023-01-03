//
//  MovieDetailView.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/02.
//

import UIKit

class MovieDetailView: UIView {
    // MARK: properties
    let posterImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title1, compatibleWith: .none)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let genreLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let runtimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ratingNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let topStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .leading
        stackView.distribution = .equalSpacing
        stackView.axis = .horizontal
        stackView.spacing = 20
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fill
        stackView.axis = .vertical
        stackView.spacing = 5
        stackView.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        stackView.setContentHuggingPriority(.defaultLow, for: .horizontal)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    let genreAndRuntimeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
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
    
    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberOfSpectatorsLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let productionYearLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let nameCollectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()

    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        configureView()
        configureUI()
        setupData()
        self.backgroundColor = .white

    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: func
    // TODO: 매개변수로 Movie 타입 받아와서 할당하기
    func setupData() {
        titleLabel.text = "광해, 왕이 된 남자"
        genreLabel.text = "사극"
        runtimeLabel.text = "131분"
        ratingNameLabel.text = "15세이상관람가"
        
        releaseDateLabel.text = "2012.09.13 개봉"
        numberOfSpectatorsLabel.text = "353274명"
        
        productionYearLabel.text = "제작연도: 2012년"
    }
    
    // MARK: private func
    private func configureView() {
        self.addSubview(topStackView)
        self.addSubview(blackStackView)
        self.addSubview(productionYearLabel)
        self.addSubview(nameCollectionView)
        
        topStackView.addArrangedSubview(posterImageView)
        topStackView.addArrangedSubview(labelStackView)
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(genreAndRuntimeStackView)
        labelStackView.addArrangedSubview(ratingNameLabel)
        
        genreAndRuntimeStackView.addArrangedSubview(genreLabel)
        genreAndRuntimeStackView.addArrangedSubview(runtimeLabel)
        
        blackStackView.addArrangedSubview(releaseDateLabel)
        blackStackView.addArrangedSubview(numberOfSpectatorsLabel)
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            topStackView.topAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.topAnchor,
                constant: 20
            ),
            topStackView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            topStackView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: 10
            ),
            
            blackStackView.topAnchor.constraint(
                equalTo: topStackView.bottomAnchor,
                constant: 10
            ),
            blackStackView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor
            ),
            blackStackView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor
            ),
            
            productionYearLabel.topAnchor.constraint(
                equalTo: blackStackView.bottomAnchor,
                constant: 10
            ),
            productionYearLabel.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            productionYearLabel.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            
            nameCollectionView.leadingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.leadingAnchor,
                constant: 20
            ),
            nameCollectionView.topAnchor.constraint(
                equalTo: productionYearLabel.bottomAnchor,
                constant: 20
            ),
            nameCollectionView.trailingAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.trailingAnchor,
                constant: -20
            ),
            nameCollectionView.bottomAnchor.constraint(
                equalTo: self.safeAreaLayoutGuide.bottomAnchor,
                constant: -350
            ),
            
            nameCollectionView.heightAnchor.constraint(equalToConstant: 70)
        ])
    }
}
