//
//  BoxOfficeListViewController.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/19.
//

import Foundation
import UIKit
import Combine
import SwiftUI

// MARK: - View Controller
class BoxOfficeListViewController: UIViewController {
    // MARK: View Components
    var dailyButton: UIButton = {
        let button = UIButton()
        button.setTitle("일별", for: .normal)
        button.titleLabel?.font = .appleSDGothicNeo(weight: .semiBold, size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var weeklyButton: UIButton = {
        let button = UIButton()
        button.setTitle("주간", for: .normal)
        button.titleLabel?.font = .appleSDGothicNeo(weight: .semiBold, size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var weekdayButton: UIButton = {
        let button = UIButton()
        button.setTitle("주말", for: .normal)
        button.titleLabel?.font = .appleSDGothicNeo(weight: .semiBold, size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var weekendButton: UIButton = {
        let button = UIButton()
        button.setTitle("평일", for: .normal)
        button.titleLabel?.font = .appleSDGothicNeo(weight: .semiBold, size: 16)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    var filterStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.alignment = .center
        stackView.spacing = 14
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.backgroundColor = UIColor(hex: "#101010")
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    // MARK: Associated Types
    typealias ViewModel = BoxOfficeListViewModel
    
    
    // MARK: Properties
    var didSetupConstraints = false
    var viewModel = ViewModel()
    var subscriptions = [AnyCancellable]()
    
    
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        buildViewHierarchy()
        self.view.setNeedsUpdateConstraints()
        bind()
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
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(BoxOfficeListCollectionViewCell.self, forCellWithReuseIdentifier: BoxOfficeListCollectionViewCell.className)
    }
    
    // MARK: Build View Hierarchy
    func buildViewHierarchy() {
        self.view.addSubview(collectionView)
        self.view.addSubview(filterStackView)
        filterStackView.addArrangedSubview(dailyButton)
        filterStackView.addArrangedSubview(weeklyButton)
        filterStackView.addArrangedSubview(weekendButton)
        filterStackView.addArrangedSubview(weekdayButton)
    }
    
    // MARK: Layout Views
    func setupConstraints() {
        var constraints = [NSLayoutConstraint]()
        
        defer { NSLayoutConstraint.activate(constraints) }
        
        constraints += [
            filterStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            filterStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            filterStackView.heightAnchor.constraint(equalToConstant: 45),
        ]
        
        constraints += [
            collectionView.topAnchor.constraint(equalTo: filterStackView.bottomAnchor),
            collectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
        ]
    }
    
    
    // MARK: Binding
    func bind() {
        // Action
        dailyButton.controlEvent(.touchUpInside)
            .map { _ in BoxOfficeFilter.daily }
            .assign(to: \.filter, on: viewModel)
            .store(in: &subscriptions)
        
        weeklyButton.controlEvent(.touchUpInside)
            .map { _ in BoxOfficeFilter.weekly }
            .assign(to: \.filter, on: viewModel)
            .store(in: &subscriptions)
        
        weekdayButton.controlEvent(.touchUpInside)
            .map { _ in BoxOfficeFilter.weekday }
            .assign(to: \.filter, on: viewModel)
            .store(in: &subscriptions)
        
        weekendButton.controlEvent(.touchUpInside)
            .map { _ in BoxOfficeFilter.weekend }
            .assign(to: \.filter, on: viewModel)
            .store(in: &subscriptions)
        
        // State
        viewModel.$filter
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] filter in
                guard let self else { return }
                let selected = UIColor(hex: "#DFDFDF")
                let unselected = UIColor(hex: "#BEBEBE")
                self.dailyButton.setTitleColor(filter == .daily ? selected : unselected, for: .normal)
                self.weeklyButton.setTitleColor(filter == .weekly ? selected : unselected, for: .normal)
                self.weekdayButton.setTitleColor(filter == .weekday ? selected : unselected, for: .normal)
                self.weekendButton.setTitleColor(filter == .weekend ? selected : unselected, for: .normal)
            }).store(in: &subscriptions)
        
        viewModel.$cellModels
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] _ in
                guard let self else { return }
                self.collectionView.reloadData()
            }).store(in: &subscriptions)
        
        viewModel.viewAction
            .receive(on: DispatchQueue.main)
            .sink(receiveValue: { [weak self] action in
                guard let self else { return }
                switch action {
                case .pushViewController(let vc):
                    self.navigationController?.pushViewController(vc, animated: true)
                }
            }).store(in: &subscriptions)
    }
}

extension BoxOfficeListViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.cellModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: BoxOfficeListCollectionViewCell.className, for: indexPath) as? BoxOfficeListCollectionViewCell
        else { return UICollectionViewCell() }
        cell.viewModel = viewModel.cellModels[indexPath.row]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfColumns: CGFloat = indexPath.row < 2 ? 2 : 3
        let width = (collectionView.bounds.width - 16 * 2 - 14 * (numberOfColumns - 1)) / numberOfColumns
        let height = BoxOfficeListCollectionViewCell.calculateCellHeight(width: width)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        self.viewModel.selectItem.send(indexPath.row)
    }
}

#if canImport(SwiftUI) && DEBUG
struct BoxOfficeListViewControllerPreview: PreviewProvider {
    static var previews: some View {
        ContentViewControllerPreview {
            return BoxOfficeListViewController()
        }
    }
}
#endif

