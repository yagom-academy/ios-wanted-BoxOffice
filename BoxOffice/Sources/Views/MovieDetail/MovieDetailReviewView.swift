//
//  MovieDetailReviewView.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/22.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class MovieDetailReviewView: UIView {
    // MARK: View Components
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .bold, size: 16)
        label.textColor = UIColor(hex: "#DFDFDF")
        label.text = "리뷰"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var averageRatingWrapperView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 10
        view.layer.borderColor = UIColor(hex: "#707070").cgColor
        view.layer.borderWidth = 1
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var averageRatingTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .medium, size: 12)
        label.textColor = UIColor(hex: "#848484")
        label.text = "평균 별점"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var averageRatingStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var averageRatingView: RatingView = {
        let view = RatingView()
        view.isUserInteractionEnabled = false
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var averageRatingLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .medium, size: 16)
        label.textColor = UIColor(hex: "#DFDFDF")
        label.text = "0"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var createReviewButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 4
        button.layer.borderColor = UIColor(hex: "#707070").cgColor
        button.layer.borderWidth = 1
        button.titleLabel?.font = .appleSDGothicNeo(weight: .regular, size: 12)
        button.setTitleColor(UIColor(hex: "#DFDFDF"), for: .normal)
        button.setTitle("리뷰 작성하기", for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var reviewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var reviewCells = [MovieDetailReviewCell]()
    
    // MARK: Associated Types
    typealias ViewModel = MovieDetailViewModel
    
    // MARK: Properties
    var didSetupConstraints = false
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel = viewModel else { return }
            bind(viewModel: viewModel)
        }
    }
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init() {
        super.init(frame: .zero)
        setupViews()
        buildViewHierarchy()
        self.setNeedsUpdateConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func updateConstraints() {
        if !didSetupConstraints {
            self.setupConstraints()
            didSetupConstraints = true
        }
        super.updateConstraints()
    }
    
    // MARK: Setup Views
    func setupViews() {
        self.backgroundColor = .clear
    }
    
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(averageRatingWrapperView)
        averageRatingWrapperView.addSubview(averageRatingTitleLabel)
        averageRatingWrapperView.addSubview(averageRatingStackView)
        averageRatingStackView.addArrangedSubview(averageRatingView)
        averageRatingStackView.addArrangedSubview(averageRatingLabel)
        self.addSubview(createReviewButton)
        self.addSubview(reviewStackView)
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ]
        
        constraints += [
            averageRatingWrapperView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            averageRatingWrapperView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            averageRatingWrapperView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            averageRatingWrapperView.heightAnchor.constraint(equalToConstant: 64),
        ]
        
        constraints += [
            averageRatingTitleLabel.topAnchor.constraint(equalTo: averageRatingWrapperView.topAnchor, constant: 12),
            averageRatingTitleLabel.centerXAnchor.constraint(equalTo: averageRatingWrapperView.centerXAnchor),
        ]
        
        constraints += [
            averageRatingStackView.topAnchor.constraint(equalTo: averageRatingTitleLabel.bottomAnchor, constant: 5),
            averageRatingStackView.centerXAnchor.constraint(equalTo: averageRatingWrapperView.centerXAnchor),
        ]
        
        constraints += [
            averageRatingView.widthAnchor.constraint(equalToConstant: 100),
            averageRatingView.heightAnchor.constraint(equalToConstant: 18),
        ]
        
        constraints += [
            createReviewButton.topAnchor.constraint(equalTo: averageRatingWrapperView.bottomAnchor, constant: 12),
            createReviewButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            createReviewButton.widthAnchor.constraint(equalToConstant: 90),
            createReviewButton.heightAnchor.constraint(equalToConstant: 28),
        ]
        
        constraints += [
            reviewStackView.topAnchor.constraint(equalTo: createReviewButton.bottomAnchor, constant: 8),
            reviewStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            reviewStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
            reviewStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
        
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        createReviewButton.controlEvent(.touchUpInside)
            .subscribe(viewModel.createReview)
            .store(in: &subscriptions)
        
        viewModel.$reviews
            .filter { $0.count > 0 }
            .map { reviews in
                Double(reviews.map { $0.rating }.reduce(0, +)) / Double(reviews.count)
            }.map { "\(round($0 * 100) / 100)" }
            .assign(to: \.text, on: averageRatingLabel)
            .store(in: &subscriptions)
        
        viewModel.$averageRatingViewModel
            .assign(to: \.viewModel, on: averageRatingView)
            .store(in: &subscriptions)
        
        viewModel.$reviewCellModels
            .compactMap { $0 }
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] models in
                guard let self else { return }
                self.reviewCells.forEach { self.reviewStackView.removeArrangedSubview($0) }
                self.reviewCells = []
                models.forEach {
                    let cell = self.createReviewCell()
                    cell.viewModel = $0
                    self.reviewCells.append(cell)
                }
                self.reviewCells.forEach { self.reviewStackView.addArrangedSubview($0) }
            }).store(in: &subscriptions)
    }
    
    // MARK: Util
    func createReviewCell() -> MovieDetailReviewCell {
        let view = MovieDetailReviewCell()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

#if canImport(SwiftUI) && DEBUG
struct MovieDetailReviewViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = MovieDetailReviewView()
            view.viewModel = MovieDetailViewModel(movie: .dummyMovie)
            return view
        }
        .background(Color(UIColor(hex: "#101010")))
        .previewLayout(.sizeThatFits)
    }
}
#endif
