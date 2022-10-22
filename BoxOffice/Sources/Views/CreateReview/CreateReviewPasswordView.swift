//
//  CreateReviewPasswordView.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/21.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class CreateReviewPasswordView: UIView {
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
        label.text = "암호"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textField: UITextField = {
        let textField = UITextField()
        textField.font = .appleSDGothicNeo(weight: .regular, size: 12)
        textField.textColor = UIColor(hex: "#DFDFDF")
        textField.isSecureTextEntry = true
        let placeholder = NSMutableAttributedString(string: "알파벳 소문자, 아라비아 숫자, 특수문자 각 1개 이상 포함")
        placeholder.setAttributesForAll([.foregroundColor: UIColor(hex: "#707070")])
        textField.attributedPlaceholder = placeholder
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
    lazy var stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.alignment = .leading
        stackView.spacing = 6
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    lazy var conditionLabels: [UILabel] = {
        let labels = [UILabel(), UILabel(), UILabel()]
        labels[0].text = "• 6-20자리"
        labels[1].text = "• 알파벳 소문자, 숫자, 특수문자 각 1개 이상 포함"
        labels[2].text = "• 사용 가능한 특수문자: !, @, #, $"
        labels.forEach {
            $0.font = .appleSDGothicNeo(weight: .regular, size: 12)
            $0.textColor = UIColor(hex: "#FF5912")
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return labels
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
        self.addSubview(stackView)
        
        conditionLabels.forEach {
            stackView.addArrangedSubview($0)
        }
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            self.heightAnchor.constraint(equalToConstant: 100),
        ]
        
        constraints += [
            circle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 24),
            circle.topAnchor.constraint(equalTo: topAnchor, constant: 18),
            circle.widthAnchor.constraint(equalToConstant: 4),
            circle.heightAnchor.constraint(equalToConstant: 4),
        ]
        
        constraints += [
            titleLabel.leadingAnchor.constraint(equalTo: circle.trailingAnchor, constant: 4),
            titleLabel.widthAnchor.constraint(equalToConstant: 25),
            titleLabel.centerYAnchor.constraint(equalTo: circle.centerYAnchor),
        ]
        
        constraints += [
            textField.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            textField.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textField.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            textField.heightAnchor.constraint(equalToConstant: 18),
        ]
        
        constraints += [
            stackView.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 5),
            stackView.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        textField.controlEvent(.editingChanged)
            .compactMap { [weak self] _ in
                guard let self else { return nil }
                return self.textField.text
            }.assign(to: \.password, on: viewModel)
            .store(in: &subscriptions)
    }
}

#if canImport(SwiftUI) && DEBUG
struct CreateReviewPasswordViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = CreateReviewPasswordView()
            view.viewModel = CreateReviewViewModel(movie: .dummyMovie)
            return view
        }.background(Color(UIColor(hex: "#101010")))
        .previewLayout(.fixed(width: 390, height: 100))
    }
}
#endif
