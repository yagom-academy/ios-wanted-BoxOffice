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
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    let ageLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title3, compatibleWith: .none)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    let labelStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
        stackView.axis = .vertical
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

    let releaseDateLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.setContentHuggingPriority(.defaultLow, for: .vertical)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberOfSpectatorsLabel: UILabel = {
        let label = UILabel()
        label.font = .preferredFont(forTextStyle: .title2)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
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
    
    let bottomStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.alignment = .fill
        stackView.distribution = .fillEqually
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

    // MARK: init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.translatesAutoresizingMaskIntoConstraints = false
        
        configureView()
        configureUI()
        setPoster(
            name: "testPost",
            age: "15",
            color: .orange
        )
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
        self.addSubview(bottomStackView)
        
        topStackView.addArrangedSubview(posterView)
        topStackView.addArrangedSubview(labelStackView)
        
        posterView.addSubview(ageLabel)
        
        labelStackView.addArrangedSubview(titleLabel)
        labelStackView.addArrangedSubview(genreAndRuntimeStackView)
        labelStackView.addArrangedSubview(ratingNameLabel)
        
        genreAndRuntimeStackView.addArrangedSubview(genreLabel)
        genreAndRuntimeStackView.addArrangedSubview(runtimeLabel)
        
        blackStackView.addArrangedSubview(releaseDateLabel)
        blackStackView.addArrangedSubview(numberOfSpectatorsLabel)
        
        bottomStackView.addArrangedSubview(productionYearLabel)
        bottomStackView.addArrangedSubview(nameCollectionView)
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
            
            ageLabel.centerYAnchor.constraint(
                equalTo: posterView.centerYAnchor,
                constant: -80
            ),
            ageLabel.centerXAnchor.constraint(
                equalTo: posterView.centerXAnchor,
                constant: 50
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

            bottomStackView.topAnchor.constraint(
                equalTo: blackStackView.bottomAnchor,
                constant: 10
            ),
            bottomStackView.trailingAnchor.constraint(
                equalTo: self.trailingAnchor,
                constant: -20
            ),
            bottomStackView.leadingAnchor.constraint(
                equalTo: self.leadingAnchor,
                constant: 20
            ),
            
            nameCollectionView.heightAnchor.constraint(
                equalToConstant: 50
            )
        ])
    }

    private func setPoster(name: String, age: String, color: UIColor) {
        var image = UIImage(named: name)
        image = image?.resize(
            newWidth: UIScreen.main.bounds.width/UIScreen.main.scale
        )
        posterView.backgroundColor = UIColor(patternImage: image!)
        ageLabel.text = age
        ageLabel.backgroundColor = color
    
        NSLayoutConstraint.activate([
            posterView.heightAnchor.constraint(
                equalToConstant: image?.size.height ?? 100
            )
        ])
    }
}

// TODO: 파일분리
extension UIImage {
    func resize(newWidth: CGFloat) -> UIImage {
        let scale = newWidth / self.size.width
        let newHeight = self.size.height * scale

        let size = CGSize(width: newWidth, height: newHeight)
        let render = UIGraphicsImageRenderer(size: size)
        let renderImage = render.image { context in
            self.draw(in: CGRect(origin: .zero, size: size))
        }

        return renderImage
    }
}
