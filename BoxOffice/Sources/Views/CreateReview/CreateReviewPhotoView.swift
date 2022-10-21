//
//  CreateReviewPhotoView.swift
//  BoxOffice
//
//  Created by 한경수 on 2022/10/21.
//

import Foundation
import UIKit
import Combine
import PhotosUI
import SwiftUI

// MARK: - View
class CreateReviewPhotoView: UIView {
    // MARK: View Components
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .appleSDGothicNeo(weight: .bold, size: 14)
        label.textColor = UIColor(hex: "#DFDFDF")
        label.text = "사진"
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.layer.cornerRadius = 4
        imageView.layer.borderColor = UIColor(hex: "#707070").cgColor
        imageView.layer.borderWidth = 1
        imageView.clipsToBounds = true
        imageView.backgroundColor = .white
        imageView.isUserInteractionEnabled = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    lazy var backgroundView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "plus")
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
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
        imageView.addGestureRecognizer(UITapGestureRecognizer())
    }
    
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.addSubview(titleLabel)
        self.addSubview(backgroundView)
        self.addSubview(imageView)
    }
    
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            self.heightAnchor.constraint(equalToConstant: 144),
        ]
        
        constraints += [
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
        ]
        
        constraints += [
            imageView.topAnchor.constraint(equalTo: topAnchor, constant: 12),
            imageView.leadingAnchor.constraint(equalTo: titleLabel.trailingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 120),
            imageView.heightAnchor.constraint(equalToConstant: 120),
        ]
        
        constraints += [
            backgroundView.centerXAnchor.constraint(equalTo: imageView.centerXAnchor),
            backgroundView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            backgroundView.widthAnchor.constraint(equalToConstant: 38),
            backgroundView.heightAnchor.constraint(equalToConstant: 38),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        imageView.gesture(.tap)
            .map { _ in ViewModel.ViewAction.showPHPicker }
            .subscribe(viewModel.viewAction)
            .store(in: &subscriptions)
        
        viewModel.$reviewImage
            .receive(on: DispatchQueue.main)
            .assign(to: \.image, on: imageView)
            .store(in: &subscriptions)
    }
}

#if canImport(SwiftUI) && DEBUG
struct CreateReviewPhotoViewPreview: PreviewProvider {
    static var previews: some View {
        ContentViewPreview {
            let view = CreateReviewPhotoView()
            view.viewModel = CreateReviewViewModel(movie: .dummyMovie)
            return view
        }.background(Color(UIColor(hex: "#101010")))
        .previewLayout(.fixed(width: 390, height: 144))
    }
}
#endif
