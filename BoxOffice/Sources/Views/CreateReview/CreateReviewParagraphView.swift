//
//  CreateReviewParagraphView.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/21.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View
class CreateReviewParagraphView: UIView {
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
        label.text = "내용"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var textView: UITextView = {
        let textView = UITextView()
        textView.font = .appleSDGothicNeo(weight: .regular, size: 12)
        textView.textColor = UIColor(hex: "#707070")
        textView.backgroundColor = .clear
        textView.text = textViewPlaceholder
        textView.textContainerInset = .zero
        textView.translatesAutoresizingMaskIntoConstraints = false
        return textView
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
    let textViewPlaceholder = "리뷰 내용을 입력해주세요"
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
        self.textView.delegate = self
    }
    
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.addSubview(circle)
        self.addSubview(titleLabel)
        self.addSubview(textView)
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            self.heightAnchor.constraint(equalToConstant: 240),
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
            textView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            textView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            textView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            textView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -12),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        
    }
}

extension CreateReviewParagraphView: UITextViewDelegate {
    func textViewDidBeginEditing(_ textView: UITextView) {
        if textView.text == textViewPlaceholder {
            textView.text = nil
            textView.textColor = UIColor(hex: "#DFDFDF")
        }
    }
    
    func textViewDidChange(_ textView: UITextView) {
        viewModel?.content = textView.text
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if textView.text == nil || textView.text!.isEmpty {
            textView.text = textViewPlaceholder
            textView.textColor = UIColor(hex: "#707070")
        }
    }
}

#if canImport(SwiftUI) && DEBUG
struct CreateReviewParagraphViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = CreateReviewParagraphView()
            view.viewModel = CreateReviewViewModel(movie: .dummyMovie)
            return view
        }.background(Color(UIColor(hex: "#101010")))
        .previewLayout(.fixed(width: 390, height: 240))
    }
}
#endif
