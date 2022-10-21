//
//  MovieDetailInfoView.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/21.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class MovieDetailInfoView: UIView {
    // MARK: View Components
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .bold, size: 16)
        label.textColor = UIColor(hex: "#DFDFDF")
        label.text = "상세설명"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var horizontalStackViews: [UIStackView] = {
        let stackViews = [UIStackView(), UIStackView()]
        stackViews.forEach {
            $0.axis = .horizontal
            $0.distribution = .fillEqually
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return stackViews
    }()
    
    lazy var cellViews: [[MovieDetailInfoCellView]] = {
        var views = [[MovieDetailInfoCellView]](repeating: [], count: 2)
        views[0].append(MovieDetailInfoCellView(type: .productionYear))
        views[0].append(MovieDetailInfoCellView(type: .openDate))
        views[0].append(MovieDetailInfoCellView(type: .audienceCount))
        views[1].append(MovieDetailInfoCellView(type: .audit))
        views[1].append(MovieDetailInfoCellView(type: .genre))
        views[1].append(MovieDetailInfoCellView(type: .showTime))
        return views
    }()
    
    // MARK: Associated Types
    typealias ViewModel = MovieDetailViewModel
    
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
        self.backgroundColor = UIColor(hex: "#101010")
    }
    
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(verticalStackView)
        horizontalStackViews.forEach {
            verticalStackView.addArrangedSubview($0)
        }
        cellViews[0].forEach {
            horizontalStackViews[0].addArrangedSubview($0)
        }
        cellViews[1].forEach {
            horizontalStackViews[1].addArrangedSubview($0)
        }
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
            verticalStackView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            verticalStackView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        cellViews.flatMap { $0 }.forEach  {
            $0.viewModel = viewModel
        }
    }
}

#if canImport(SwiftUI) && DEBUG
struct MovieDetailInfoViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = MovieDetailInfoView()
            view.viewModel = MovieDetailViewModel(movie: .dummyMovie)
            return view
        }.previewLayout(.fixed(width: 358, height: 151))
    }
}
#endif
