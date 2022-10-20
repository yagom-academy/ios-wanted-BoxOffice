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
    lazy var posterView: MoviePosterView = {
        let view = MoviePosterView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .bold, size: 16)
        label.textColor = UIColor(hex: "#DFDFDF")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var openDateLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .medium, size: 12)
        label.textColor = UIColor(hex: "#848484")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var audienceCountLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .medium, size: 12)
        label.textColor = UIColor(hex: "#848484")
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
        super.prepareForReuse()
        subscriptions = []
        posterView.clearAll()
        titleLabel.text = ""
        openDateLabel.text = ""
        audienceCountLabel.text = ""
    }
    
    // MARK: Setup Views
    func setupViews() {
        
    }
    
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.contentView.addSubview(posterView)
        self.contentView.addSubview(titleLabel)
        self.contentView.addSubview(openDateLabel)
        self.contentView.addSubview(audienceCountLabel)
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            posterView.topAnchor.constraint(equalTo: contentView.topAnchor),
            posterView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            posterView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            posterView.heightAnchor.constraint(equalTo: posterView.widthAnchor, multiplier: 15 / 11),
        ]
        
        constraints += [
            titleLabel.topAnchor.constraint(equalTo: posterView.bottomAnchor, constant: 12),
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
        viewModel.$posterModel
            .compactMap { $0 }
            .assign(to: \.viewModel, on: posterView)
            .store(in: &subscriptions)
        
        viewModel.$movie
            .map { $0.movieName }
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: titleLabel)
            .store(in: &subscriptions)
        
        viewModel.$movie
            .map { $0.openDate }
            .map { "\($0) 개봉" }
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: openDateLabel)
            .store(in: &subscriptions)
        
        viewModel.$movie
            .compactMap { $0.boxOfficeInfo?.audienceAccumulation }
            .map { "누적관객 \($0.formattedString(.audience))명  " }
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: audienceCountLabel)
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
