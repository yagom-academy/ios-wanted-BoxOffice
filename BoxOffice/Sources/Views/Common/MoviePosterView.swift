//
//  MoviePosterView.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/20.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class MoviePosterView: UIView {
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
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var rankIntenImage: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var rankIntenLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .semiBold, size: 16)
        label.textColor = UIColor(hex:"#FFC700")
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
    
    // MARK: Associated Types
    typealias ViewModel = MoviePosterViewModel
    
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
        
    }
    
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.addSubview(posterImageView)
        self.addSubview(rankLabel)
        self.addSubview(rankIntenStackView)
        rankIntenStackView.addArrangedSubview(rankIntenImage)
        rankIntenStackView.addArrangedSubview(rankIntenLabel)
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            posterImageView.topAnchor.constraint(equalTo: topAnchor),
            posterImageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            posterImageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            posterImageView.bottomAnchor.constraint(equalTo: bottomAnchor),
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
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        viewModel.$posterImage
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: posterImageView)
            .store(in: &subscriptions)
        
        viewModel.$movie
            .compactMap { $0.boxOfficeInfo?.rank }
            .map { String($0) }
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: rankLabel)
            .store(in: &subscriptions)
        
        viewModel.$movie
            .compactMap { $0.boxOfficeInfo }
            .receive(on: DispatchQueue.main)
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
                    self.rankIntenLabel.text = String(-info.rankInten)
                    self.rankIntenLabel.textColor = UIColor(hex: "#00E0FF")
                    self.rankIntenImage.isHidden = false
                    self.rankIntenLabel.isHidden = false
                }
            }).store(in: &subscriptions)
    }
    
    // MARK: Util
    func clearAll() {
        posterImageView.image = nil
        rankLabel.text = ""
        rankIntenImage.isHidden = true
        rankIntenLabel.isHidden = true
    }
}

#if canImport(SwiftUI) && DEBUG
struct MoviePosterViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = MoviePosterView()
            view.viewModel = MoviePosterViewModel(movie: .dummyMovie)
            return view
        }.previewLayout(.fixed(width: 110, height: 150))
    }
}
#endif
