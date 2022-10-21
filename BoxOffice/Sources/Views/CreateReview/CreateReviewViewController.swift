//
//  CreateReviewViewController.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/21.
//

import Foundation
import UIKit
import Combine
import PhotosUI
import SwiftUI

// MARK: - View Controller
class CreateReviewViewController: UIViewController {
    // MARK: View Components
    lazy var navigationView: CreateReviewNavigationView = {
        let view = CreateReviewNavigationView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        return scrollView
    }()
    
    lazy var contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var infoView: CreateReviewMovieInfoView = {
        let view = CreateReviewMovieInfoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var ratingView: CreateReviewRatingView = {
        let view = CreateReviewRatingView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var nicknameView: CreateReviewNicknameView = {
        let view = CreateReviewNicknameView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var passwordView: CreateReviewPasswordView = {
        let view = CreateReviewPasswordView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var paragraphView: CreateReviewParagraphView = {
        let view = CreateReviewParagraphView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var photoView: CreateReviewPhotoView = {
        let view = CreateReviewPhotoView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var dividerViews: [UIView] = {
        var views = [UIView(), UIView(), UIView(), UIView(), UIView()]
        views.forEach {
            $0.backgroundColor = UIColor(hex: "#707070").withAlphaComponent(0.6)
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        return views
    }()
    
    lazy var confirmButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor(hex: "#707070").cgColor
        button.layer.borderWidth = 1
        button.setTitle("작성 완료", for: .normal)
        button.setTitleColor(UIColor(hex: "#DFDFDF"), for: .normal)
        button.setTitleColor(UIColor(hex: "#DFDFDF").withAlphaComponent(0.2), for: .disabled)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    lazy var activityIndicator: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .large)
        view.color = .blue
        view.backgroundColor = .white.withAlphaComponent(0.2)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var picker: PHPickerViewController = {
        var configuration = PHPickerConfiguration()
        configuration.filter = .any(of: [.images])
        let picker = PHPickerViewController(configuration: configuration)
        return picker
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
    
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        buildViewHierarchy()
        self.view.setNeedsUpdateConstraints()
    }
    
    override func updateViewConstraints() {
        if !didSetupConstraints {
            self.setupConstraints()
            didSetupConstraints = true
        }
        super.updateViewConstraints()
    }
    
    
    // MARK: Setup Views
    func setupViews() {
        self.view.backgroundColor = UIColor(hex: "#101010")
        picker.delegate = self
    }
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.view.addSubview(navigationView)
        self.view.addSubview(scrollView)
        self.view.addSubview(confirmButton)
        self.view.addSubview(activityIndicator)
        scrollView.addSubview(contentView)
        contentView.addSubview(infoView)
        contentView.addSubview(ratingView)
        contentView.addSubview(nicknameView)
        contentView.addSubview(passwordView)
        contentView.addSubview(paragraphView)
        contentView.addSubview(photoView)
        dividerViews.forEach {
            contentView.addSubview($0)
        }
    }
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            navigationView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            navigationView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            navigationView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            navigationView.heightAnchor.constraint(equalToConstant: 45),
        ]
        
        constraints += [
            scrollView.topAnchor.constraint(equalTo: navigationView.bottomAnchor),
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
        ]
        
        constraints += [
            contentView.topAnchor.constraint(equalTo: scrollView.contentLayoutGuide.topAnchor),
            contentView.leadingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.leadingAnchor),
            contentView.trailingAnchor.constraint(equalTo: scrollView.contentLayoutGuide.trailingAnchor),
            contentView.bottomAnchor.constraint(equalTo: scrollView.contentLayoutGuide.bottomAnchor),
            contentView.widthAnchor.constraint(equalTo: scrollView.frameLayoutGuide.widthAnchor),
        ]
        
        constraints += [
            infoView.topAnchor.constraint(equalTo: contentView.topAnchor),
            infoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            infoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        
        constraints += [
            dividerViews[0].topAnchor.constraint(equalTo: infoView.bottomAnchor),
            dividerViews[0].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dividerViews[0].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dividerViews[0].heightAnchor.constraint(equalToConstant: 1),
        ]
        
        constraints += [
            ratingView.topAnchor.constraint(equalTo: dividerViews[0].bottomAnchor),
            ratingView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            ratingView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        
        constraints += [
            dividerViews[1].topAnchor.constraint(equalTo: ratingView.bottomAnchor),
            dividerViews[1].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dividerViews[1].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dividerViews[1].heightAnchor.constraint(equalToConstant: 1),
        ]
        
        constraints += [
            nicknameView.topAnchor.constraint(equalTo: dividerViews[1].bottomAnchor),
            nicknameView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            nicknameView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        
        constraints += [
            dividerViews[2].topAnchor.constraint(equalTo: nicknameView.bottomAnchor),
            dividerViews[2].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dividerViews[2].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dividerViews[2].heightAnchor.constraint(equalToConstant: 1),
        ]
        
        constraints += [
            passwordView.topAnchor.constraint(equalTo: dividerViews[2].bottomAnchor),
            passwordView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            passwordView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
        ]
        
        constraints += [
            dividerViews[3].topAnchor.constraint(equalTo: passwordView.bottomAnchor),
            dividerViews[3].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dividerViews[3].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dividerViews[3].heightAnchor.constraint(equalToConstant: 1),
        ]
        
        constraints += [
            paragraphView.topAnchor.constraint(equalTo: dividerViews[3].bottomAnchor),
            paragraphView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            paragraphView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        ]
        
        constraints += [
            dividerViews[4].topAnchor.constraint(equalTo: paragraphView.bottomAnchor),
            dividerViews[4].leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16),
            dividerViews[4].trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16),
            dividerViews[4].heightAnchor.constraint(equalToConstant: 1),
        ]
        
        constraints += [
            photoView.topAnchor.constraint(equalTo: dividerViews[4].bottomAnchor),
            photoView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            photoView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            photoView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor),
        ]
        
        constraints += [
            confirmButton.topAnchor.constraint(equalTo: scrollView.bottomAnchor),
            confirmButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            confirmButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            confirmButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            confirmButton.heightAnchor.constraint(equalToConstant: 56),
        ]
        
        constraints += [
            activityIndicator.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            activityIndicator.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            activityIndicator.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            activityIndicator.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
    }
    
    
    // MARK: Binding
    func bind(viewModel: ViewModel) {
        view.gesture(.tap)
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let self else { return }
                self.view.endEditing(true)
            }).store(in: &subscriptions)
        
        confirmButton.controlEvent(.touchUpInside)
            .subscribe(viewModel.submit)
            .store(in: &subscriptions)
        
        viewModel.viewAction
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] action in
                guard let self else { return }
                switch action {
                case .dismiss:
                    self.navigationController?.popViewController(animated: true)
                case .showPHPicker:
                    self.present(self.picker, animated: true)
                }
            }).store(in: &subscriptions)
        
        viewModel.$isValid
            .receive(on: DispatchQueue.main)
            .assign(to: \.isEnabled, on: confirmButton)
            .store(in: &subscriptions)
        
        viewModel.$isLoading
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] isLoading in
                guard let self else { return }
                if isLoading {
                    self.activityIndicator.isHidden = false
                    self.activityIndicator.startAnimating()
                } else {
                    self.activityIndicator.isHidden = true
                    self.activityIndicator.stopAnimating()
                }
            }).store(in: &subscriptions)
        
        navigationView.viewModel = viewModel
        infoView.viewModel = viewModel
        ratingView.viewModel = viewModel
        nicknameView.viewModel = viewModel
        passwordView.viewModel = viewModel
        paragraphView.viewModel = viewModel
        photoView.viewModel = viewModel
    }
    
    // MARK: Util
    func getDividerView() -> UIView {
        let view = UIView()
        view.backgroundColor = UIColor(hex: "#707070").withAlphaComponent(0.6)
        view.heightAnchor.constraint(equalToConstant: 1).isActive = true
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }
}

extension CreateReviewViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        if let itemProvider = results.first?.itemProvider {
            if itemProvider.canLoadObject(ofClass: UIImage.self) {
                itemProvider.loadObject(ofClass: UIImage.self, completionHandler: { [weak self] image, error in
                    guard let self,
                          let image = image as? UIImage
                    else { return }
                    self.viewModel?.reviewImage = image
                })
            }
        }
    }
}

#if canImport(SwiftUI) && DEBUG
struct CreateReviewViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            let vc = CreateReviewViewController()
            vc.viewModel = CreateReviewViewModel(movie: .dummyMovie)
            return vc
        }
    }
}
#endif

