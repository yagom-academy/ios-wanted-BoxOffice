//
//  TriSectoredStackView.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/21.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class TriSectoredStackView: UIView {
    // MARK: View Components
    lazy var verticalStackView: UIStackView = {
        let view = UIStackView()
        view.axis = .vertical
        view.distribution = .fillEqually
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var horizontalStackViews = [UIStackView]()
    
    lazy var cellViews = [CenterLabelView]()
    
    lazy var topBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#707070").withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var bottomBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#707070").withAlphaComponent(0.7)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    // MARK: Associated Types
    typealias ViewModel = TriSectoredStackViewModel
    
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
        self.addSubview(verticalStackView)
        self.addSubview(topBorderView)
        self.addSubview(bottomBorderView)
    }
    
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            topBorderView.topAnchor.constraint(equalTo: topAnchor),
            topBorderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            topBorderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            topBorderView.heightAnchor.constraint(equalToConstant: 1),
        ]
        
        constraints += [
            verticalStackView.topAnchor.constraint(equalTo: topBorderView.bottomAnchor),
            verticalStackView.leadingAnchor.constraint(equalTo: leadingAnchor),
            verticalStackView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ]
        
        constraints += [
            bottomBorderView.topAnchor.constraint(equalTo: verticalStackView.bottomAnchor),
            bottomBorderView.leadingAnchor.constraint(equalTo: leadingAnchor),
            bottomBorderView.trailingAnchor.constraint(equalTo: trailingAnchor),
            bottomBorderView.bottomAnchor.constraint(equalTo: bottomAnchor),
            bottomBorderView.heightAnchor.constraint(equalToConstant: 1),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        viewModel.$labelViewModels
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] models in
                guard let self else { return }
                self.clearAllViews()
                models.enumerated().forEach { index, model in
                    if index % 3 == 0 {
                        let stackView = self.createHorizontalStackView()
                        self.horizontalStackViews.append(stackView)
                    }
                    self.cellViews[index].viewModel = model
                }
                self.horizontalStackViews.forEach { self.verticalStackView.addArrangedSubview($0) }
            }).store(in: &subscriptions)
    }
    
    // MARK: Util
    func createHorizontalStackView() -> UIStackView {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.addArrangedSubview(createCenterLabelView(location: .leading))
        stackView.addArrangedSubview(createCenterLabelView(location: .center))
        stackView.addArrangedSubview(createCenterLabelView(location: .trailing))
        stackView.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }
    
    func createCenterLabelView(location: CenterLabelView.Location) -> CenterLabelView {
        let view = CenterLabelView(location: location)
        self.cellViews.append(view)
        return view
    }
    
    func clearAllViews() {
        self.horizontalStackViews.forEach {
            self.verticalStackView.removeArrangedSubview($0)
        }
        self.horizontalStackViews = []
        self.cellViews = []
    }
}

#if canImport(SwiftUI) && DEBUG
struct TriSectoredStackViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = TriSectoredStackView()
            view.viewModel = TriSectoredStackViewModel(list: ["가가가", "나나나", "다다다", "라라라", "마", "바", "사"])
            return view
        }.background(Color(UIColor(hex: "#101010")))
        .previewLayout(.fixed(width: 358, height: 164))
    }
}
#endif
