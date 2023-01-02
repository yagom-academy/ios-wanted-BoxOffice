//
//  MovieDetailTabBarHeaderView.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import UIKit

final class MovieDetailTabBarHeaderView: UICollectionReusableView {
    static let reuseIdentifier = "movieDetailTabBarHeaderView"

    private let movieInfoButton: UIButton = {
        let button = UIButton()
        button.setTitle("영화정보", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let reviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("실관람평", for: .normal)
        button.setTitleColor(.label, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    private let movieInfoSelectLine: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = .black
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()

    private let reviewSelectLine: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = .black
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()

    private let divisionLine: UIView = {
        let line = UIView(frame: .zero)
        line.backgroundColor = .systemGray4
        line.translatesAutoresizingMaskIntoConstraints = false
        return line
    }()

    private var mode: MovieDetailViewModel.TabBarMode = .movieInfo {
        didSet {
            mode == .movieInfo ? setTabForMovieInfo() : setTabForReview()
        }
    }

    var movieInfoButtonTapped: (() -> Void)?
    var reviewButtonTapped: (() -> Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }

    func setUpContents() {
        layout()
        addButtonTargets()
        setTabForMovieInfo()
    }

    private func setTabForMovieInfo() {
        movieInfoSelectLine.isHidden = false
        reviewSelectLine.isHidden = true
    }

    private func setTabForReview() {
        movieInfoSelectLine.isHidden = true
        reviewSelectLine.isHidden = false
    }

    private func addButtonTargets() {
        movieInfoButton.addTarget(self, action: #selector(productListButtonTapped(_:)), for: .touchUpInside)
        reviewButton.addTarget(self, action: #selector(reviewButtonTapped(_:)), for: .touchUpInside)
    }

    private func layout() {
        [movieInfoButton, reviewButton, divisionLine, movieInfoSelectLine, reviewSelectLine].forEach {
            addSubview($0)
        }

        NSLayoutConstraint.activate([
            movieInfoButton.leadingAnchor.constraint(equalTo: leadingAnchor),
            movieInfoButton.topAnchor.constraint(equalTo: topAnchor),
            movieInfoButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            movieInfoButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),

            reviewButton.leadingAnchor.constraint(equalTo: movieInfoSelectLine.trailingAnchor),
            reviewButton.topAnchor.constraint(equalTo: topAnchor),
            reviewButton.bottomAnchor.constraint(equalTo: bottomAnchor),
            reviewButton.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.5),

            divisionLine.leadingAnchor.constraint(equalTo: leadingAnchor),
            divisionLine.bottomAnchor.constraint(equalTo: bottomAnchor),
            divisionLine.trailingAnchor.constraint(equalTo: trailingAnchor),
            divisionLine.heightAnchor.constraint(equalToConstant: Constraint.divisionLineHeight),

            movieInfoSelectLine.centerXAnchor.constraint(equalTo: movieInfoButton.centerXAnchor),
            movieInfoSelectLine.widthAnchor.constraint(equalTo: movieInfoButton.widthAnchor, multiplier: Constraint.selectLineMultiplier),
            movieInfoSelectLine.centerYAnchor.constraint(equalTo: divisionLine.centerYAnchor),
            movieInfoSelectLine.heightAnchor.constraint(equalToConstant: Constraint.selectLineHeight),

            reviewSelectLine.centerXAnchor.constraint(equalTo: reviewButton.centerXAnchor),
            reviewSelectLine.widthAnchor.constraint(equalTo: reviewButton.widthAnchor, multiplier: Constraint.selectLineMultiplier),
            reviewSelectLine.centerYAnchor.constraint(equalTo: divisionLine.centerYAnchor),
            reviewSelectLine.heightAnchor.constraint(equalToConstant: Constraint.selectLineHeight)
        ])

        divisionLine.layer.zPosition = Constraint.divisionLineZPosition
        movieInfoSelectLine.layer.zPosition = Constraint.selectLineZPosition
        reviewSelectLine.layer.zPosition = Constraint.selectLineZPosition
    }

    @objc
    private func productListButtonTapped(_ sender: UIButton) {
        movieInfoButtonTapped?()
        mode = .movieInfo
    }

    @objc
    private func reviewButtonTapped(_ sender: UIButton) {
        reviewButtonTapped?()
        mode = .review
    }
}

extension MovieDetailTabBarHeaderView {
    enum Constraint {
        static let headerViewLeadingInset: CGFloat = 25
        static let tabSpacing: CGFloat = 15
        static let divisionLineZPosition: CGFloat = 0
        static let selectLineZPosition: CGFloat = 1
        static let selectLineHeight: CGFloat = 2
        static let divisionLineHeight: CGFloat = 1
        static let selectLineMultiplier: CGFloat = 1
    }
}
