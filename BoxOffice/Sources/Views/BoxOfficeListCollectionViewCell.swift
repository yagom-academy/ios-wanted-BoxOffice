//
//  BoxOfficeListCollectionViewCell.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/19.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class BoxOfficeListCollectionViewCell: UICollectionViewCell {
    // MARK: View Components
    lazy var posterImageView: OverlayedImageView = {
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.clear.cgColor, UIColor.black.cgColor]
        gradientLayer.locations = [0.72 , 1]
        let imageView = OverlayedImageView(layer: gradientLayer)
        imageView.layer.cornerRadius = 12
        imageView.clipsToBounds = true
        imageView.backgroundColor = UIColor(hex: "#D9D9D9")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var rankLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .semiBold, size: 52)
        label.textColor = .white
        #if DEBUG
        label.text = "10"
        #endif
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rankIntenImage: UIImageView = {
        let imageView = UIImageView()
        #if DEBUG
        imageView.image = UIImage(named: "rankIntenUp")
        #endif
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var rankIntenLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .semiBold, size: 16)
        label.textColor = UIColor(hex:"#FFC700")
        #if DEBUG
        label.text = "3"
        #endif
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rankIntenStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.alignment = .center
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .semiBold, size: 16)
        label.textColor = UIColor(hex: "#222222")
        #if DEBUG
        label.text = "영화명이 들어갑니다 영화명이 들어갑니다"
        #endif
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var openDateLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .medium, size: 12)
        label.textColor = UIColor(hex: "#9A9A9A")
        #if DEBUG
        label.text = "2022.08.10 개봉"
        #endif
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var audienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .medium, size: 12)
        label.textColor = UIColor(hex: "#9A9A9A")
        #if DEBUG
        label.text = "누적관객 88만"
        #endif
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    // MARK: Associated Types
    typealias ViewModel = BoxOfficeListCollectionViewCellModel
    
    // MARK: Properties
    var didSetupConstraints = false
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel else { return }
            bind(viewModel: viewModel)
        }
    }
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    override init(frame: CGRect) {
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
    
    override func prepareForReuse() {
        subscriptions = []
        super.prepareForReuse()
    }
    
    // MARK: Setup Views
    func setupViews() {
        
    }
    
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.contentView.addSubview(posterImageView)
        self.contentView.addSubview(rankLabel)
        self.contentView.addSubview(rankIntenStackView)
        rankIntenStackView.addArrangedSubview(rankIntenImage)
        rankIntenStackView.addArrangedSubview(rankIntenLabel)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(openDateLabel)
        self.contentView.addSubview(audienceCountLabel)
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            posterImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterImageView.heightAnchor.constraint(equalTo: posterImageView.widthAnchor, multiplier: 15 / 11)
        ]
        
        constraints += [
            rankLabel.leadingAnchor.constraint(equalTo: posterImageView.leadingAnchor, constant: 12),
            rankLabel.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 16),
        ]
        
        constraints += [
            rankIntenImage.widthAnchor.constraint(equalToConstant: 8),
            rankIntenImage.heightAnchor.constraint(equalToConstant: 6)
        ]
        
        constraints += [
            rankIntenStackView.leadingAnchor.constraint(equalTo: rankLabel.trailingAnchor, constant: 4),
            rankIntenStackView.bottomAnchor.constraint(equalTo: posterImageView.bottomAnchor),
            rankIntenStackView.heightAnchor.constraint(equalToConstant: 19),
        ]
        
        constraints += [
            titleLabel.topAnchor.constraint(equalTo: posterImageView.bottomAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        
        constraints += [
            openDateLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 4),
            openDateLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            openDateLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        
        constraints += [
            audienceCountLabel.topAnchor.constraint(equalTo: openDateLabel.bottomAnchor),
            audienceCountLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            audienceCountLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        viewModel.$posterImage
            .receive(on: RunLoop.main)
            .assign(to: \.image, on: posterImageView)
            .store(in: &subscriptions)
        
        viewModel.$movie
            .compactMap { $0.boxOfficeInfo?.rank }
            .map { String($0) }
            .receive(on: RunLoop.main)
            .assign(to: \.text, on: rankLabel)
            .store(in: &subscriptions)
        
        viewModel.$movie
            .compactMap { $0.boxOfficeInfo }
            .receive(on: RunLoop.main)
            .sink(receiveValue: { [weak self] info in
                guard let self else { return }
                if info.rankOldAndNew == .NEW {
                    self.rankIntenLabel.text = "new"
                    self.rankIntenLabel.textColor = UIColor(hex: "#05FF00")
                    self.rankIntenLabel.isHidden = false
                    self.rankIntenImage.isHidden = true
                } else if info.rankInten > 0 {
                    self.rankIntenImage.image = UIImage(named: "rankIntenUp")
                    self.rankIntenLabel.text = String(info.rankInten)
                    self.rankIntenLabel.textColor = UIColor(hex: "#FFC700")
                    self.rankIntenImage.isHidden = false
                    self.rankIntenLabel.isHidden = false
                } else if info.rankInten == 0 {
                    self.rankIntenImage.image = UIImage(named: "rankIntenKeep")
                    self.rankIntenImage.isHidden = false
                    self.rankIntenLabel.isHidden = true
                } else if info.rankInten < 0 {
                    self.rankIntenImage.image = UIImage(named: "rankIntenDown")
                    self.rankIntenLabel.text = String(info.rankInten)
                    self.rankIntenLabel.textColor = UIColor(hex: "#00E0FF")
                    self.rankIntenImage.isHidden = false
                    self.rankIntenLabel.isHidden = false
                }
            }).store(in: &subscriptions)
        
        viewModel.$movie
            .map { $0.movieName }
            .receive(on: RunLoop.main)
            .assign(to: \.text, on: titleLabel)
            .store(in: &subscriptions)
        
        viewModel.$movie
            .map { $0.openDate }
            .map { "\($0) 개봉" }
            .receive(on: RunLoop.main)
            .assign(to: \.text, on: openDateLabel)
            .store(in: &subscriptions)
    }
    
    // MARK: Util
    static func calculateCellHeight(width: CGFloat) -> CGFloat {
        return (width * 15 / 11) + 65
    }
}

#if canImport(SwiftUI) && DEBUG
struct BoxOfficeListCollectionViewCellPreview: PreviewProvider {
    static var previews: some View {
        let width: CGFloat = 115
        let height = BoxOfficeListCollectionViewCell.calculateCellHeight(width: width)
        let viewModel = BoxOfficeListCollectionViewCellModel(movie: Movie.dummyMovie)
        ContentViewPreview {
            let cell = BoxOfficeListCollectionViewCell(frame: .zero)
            cell.viewModel = viewModel
            return cell
        }.previewLayout(.fixed(width: width, height: height))
    }
}
#endif
