//
//  CenterLabelView.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/21.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class CenterLabelView: UIView {
    // MARK: View Components
    lazy var label: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .medium, size: 14)
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
    typealias ViewModel = CenterLabelViewModel
    
    // MARK: Properties
    var didSetupConstraints = false
    var viewModel: ViewModel? {
        didSet {
            guard let viewModel else { return }
            bind(viewModel: viewModel)
        }
    }
    var subscriptions = [AnyCancellable]()
    let location: Location
    
    // MARK: Life Cycle
    init(location: Location) {
        self.location = location
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
        switch location {
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
        self.addSubview(label)
        borderViews.forEach { self.addSubview($0.value) }
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            label.centerXAnchor.constraint(equalTo: centerXAnchor),
            label.centerYAnchor.constraint(equalTo: centerYAnchor),
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
        viewModel.$title
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: label)
            .store(in: &subscriptions)
    }
    
    enum Location {
        case leading
        case center
        case trailing
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
struct CenterLabelViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = CenterLabelView(location: .center)
            view.viewModel = CenterLabelViewModel(title: "떙떙떙")
            return view
        }.previewLayout(.fixed(width: 120, height: 40))
    }
}
#endif
