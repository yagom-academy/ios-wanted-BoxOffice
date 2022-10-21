//
//  CreateReviewNicknameView.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/21.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class CreateReviewNicknameView: UIView {
    // MARK: View Components
    lazy var circle: UIImageView = {
        let view = UIImageView()
        view.image = UIImage(named: "circle")
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .bold, size: 14)
        label.textColor = UIColor(hex: "#DFDFDF")
        label.text = "별명"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .appleSDGothicNeo(weight: .regular, size: 12)
        textField.textColor = UIColor(hex: "#DFDFDF")
        let placeholder = NSMutableAttributedString(string: "별명을 입력해주세요")
        placeholder.setAttributesForAll([.foregroundColor: UIColor(hex: "#707070")])
        textField.attributedPlaceholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    // MARK: Associated Types
    typealias ViewModel = CreateReviewViewModel
    
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
        self.addSubview(circle)
        self.addSubview(titleLabel)
        self.addSubview(textField)
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            self.heightAnchor.constraint(equalToConstant: 40),
        ]
        
        constraints += [
            circle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            circle.centerYAnchor.constraint(equalTo: centerYAnchor),
            circle.widthAnchor.constraint(equalToConstant: 4),
            circle.heightAnchor.constraint(equalToConstant: 4),
        ]
        
        constraints += [
            titleLabel.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 4),
            titleLabel.widthAnchor.constraint(equalToConstant: 25),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
        ]
        
        constraints += [
            textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textField.centerYAnchor.constraint(equalTo: centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 18),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        textField.controlEvent(.editingChanged)
            .compactMap { [weak self] _ in
                guard let self else { return nil }
                return self.textField.text
            }.assign(to: \.nickname, on: viewModel)
            .store(in: &subscriptions)
    }
}

#if canImport(SwiftUI) && DEBUG
struct CreateReviewNicknameViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = CreateReviewNicknameView()
            view.viewModel = CreateReviewViewModel(movie: .dummyMovie)
            return view
        }.background(Color(UIColor(hex: "#101010")))
        .previewLayout(.fixed(width: 390, height: 40))
    }
}
#endif
