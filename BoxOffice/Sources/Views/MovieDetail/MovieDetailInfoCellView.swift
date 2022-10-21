//
//  MovieDetailInfoCellView.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/21.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class MovieDetailInfoCellView: UIView {
    // MARK: View Components
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .medium, size: 12)
        label.textColor = UIColor(hex: "#848484")
        label.text = type.title
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .bold, size: 14)
        label.textColor = UIColor(hex: "#DFDFDF")
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var borderViews: [BorderViewType: UIView] = {
        var views = [BorderViewType: UIView]()
        BorderViewType.allCases.forEach { type in
            let view = UIView()
            view.backgroundColor = UIColor(hex: "#707070").withAlphaComponent(0.7)
            view.translatesAutoresizingMaskIntoConstraints = false
            views[type] = view
        }
        return views
    }()
    
    // MARK: Associated Types
    typealias ViewModel = MovieDetailViewModel
    
    // MARK: Properties
    var didSetupConstraints = false
    let type: ViewType
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel else { return }
            bind(viewModel: viewModel)
        }
    }
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init(type: ViewType) {
        self.type = type
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
        switch self.type.location {
        case .leading:
            borderViews[.leading]?.isHidden = true
        case .center:
            break
        case .trailing:
            borderViews[.trailing]?.isHidden = true
        }
    }
    
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(contentLabel)
        borderViews.forEach { self.addSubview($0.value) }
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]
        
        constraints += [
            contentLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            contentLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
        ]
        
        borderViews.forEach { type, borderView in
            if type.horizontal {
                constraints += [
                    borderView.leadingAnchor.constraint(equalTo: leadingAnchor),
                    borderView.trailingAnchor.constraint(equalTo: trailingAnchor),
                    borderView.heightAnchor.constraint(equalToConstant: 1),
                ]
            } else {
                constraints += [
                    borderView.topAnchor.constraint(equalTo: topAnchor),
                    borderView.bottomAnchor.constraint(equalTo: bottomAnchor),
                    borderView.widthAnchor.constraint(equalToConstant: 1),
                ]
            }
            switch type {
            case .top: constraints += [borderView.topAnchor.constraint(equalTo: topAnchor)]
            case .bottom: constraints += [borderView.bottomAnchor.constraint(equalTo: bottomAnchor)]
            case .leading: constraints += [borderView.leadingAnchor.constraint(equalTo: leadingAnchor)]
            case .trailing: constraints += [borderView.trailingAnchor.constraint(equalTo: trailingAnchor)]
            }
        }
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        viewModel.$movie
            .receive(on: DispatchQueue.main)
            .map { [weak self] movie in
                guard let self else { return "" }
                switch self.type {
                case .productionYear: return movie.detailInfo?.productionYear ?? ""
                case .openDate: return movie.openDate.toString(.yyyyMMddDot)
                case .audienceCount: return "\(movie.boxOfficeInfo?.audienceAccumulation.formattedString(.audience) ?? "")명"
                case .audit: return movie.detailInfo?.audit ?? ""
                case .genre: return movie.detailInfo?.genres.reduce("", { $0.isEmpty ? $1 : "\($0)/\($1)" }) ?? ""
                case .showTime: return movie.detailInfo?.showTime.formattedString(.showTime) ?? ""
                }
            }.assign(to: \.text, on: contentLabel)
            .store(in: &subscriptions)
    }
    
    enum ViewType: CaseIterable {
        case productionYear
        case openDate
        case audienceCount
        case audit
        case genre
        case showTime
        
        var title: String {
            switch self {
            case .productionYear: return "제작연도"
            case .openDate: return "개봉일"
            case .audienceCount: return "누적관객"
            case .audit: return "관람등급명칭"
            case .genre: return "장르"
            case .showTime: return "상영시간"
            }
        }
        
        var location: Location {
            switch self {
            case .productionYear, .audit: return .leading
            case .openDate, .genre: return .center
            case .audienceCount, .showTime: return .trailing
            }
        }
        
        enum Location {
            case leading
            case center
            case trailing
        }
    }
    
    enum BorderViewType: String, CaseIterable, Hashable {
        case top
        case bottom
        case leading
        case trailing
        
        var vertical: Bool {
            switch self {
            case .leading, .trailing: return true
            case .top, .bottom: return false
            }
        }
        
        var horizontal: Bool {
            switch self {
            case .top, .bottom: return true
            case .leading, .trailing: return false
            }
        }
    }
}

#if canImport(SwiftUI) && DEBUG
struct MovieDetailInfoCellViewPreview: PreviewProvider {
    static var previews: some View {
        VStack {
            ForEach(MovieDetailInfoCellView.ViewType.allCases, id: \.self) { type in
                ContentViewPreview {
                    let view = MovieDetailInfoCellView(type: type)
                    view.viewModel = MovieDetailViewModel(movie: .dummyMovie)
                    return view
                }
            }
        }.previewLayout(.fixed(width: 120, height: 360))
    }
}
#endif
