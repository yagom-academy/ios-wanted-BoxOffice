//
//  MainView.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/03.
//

import UIKit

enum BoxOfficeConstraint {
    static let deviceWidth = UIScreen.main.bounds.width
    static let deviceHeight = UIScreen.main.bounds.height
    static let minimumInteritemSpacing: CGFloat = 10
    static let numberOfCells: CGFloat = 2.5
    static let inset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
}

final class MainView: UIView {
    
    private lazy var backgroundImage: UIImageView = {
        let imageView = UIImageView(image: (UIImage(named: "dummyPoster")))
        imageView.isOpaque = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    private lazy var diminishView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = UIColor(r: 188, g: 181, b: 181, a: 0.5)
        return view
    }()
    
    private lazy var sheetView: UIView = {
        let view = UIView(frame: .zero)
        view.backgroundColor = .systemGray6
        return view
    }()
    
    private lazy var boxOfficeLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "BOX OFFICE"
        label.font = .systemFont(ofSize: 25, weight: .bold)
        return label
    }()
    
    lazy var collectionView: UICollectionView = {
        let layout = configureFlowLayout()
        let collectionView = UICollectionView(
            frame: .zero,
            collectionViewLayout: layout
        )
        collectionView.backgroundColor = .systemGray6
        return collectionView
    }()
    
    private lazy var dailyWeeklyToggle: UIButton = {
        let button = UIButton(frame: .zero)
        button.setTitle("DAILY", for: .normal)
        button.titleLabel?.font = .preferredFont(forTextStyle: .headline)
        button.backgroundColor = UIColor(r: 76, g: 52, b: 145)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        collectionView.register(MainViewCell.self, forCellWithReuseIdentifier: MainViewCell.identifier)
        collectionView.showsHorizontalScrollIndicator = false
        addSubviews(
            backgroundImage,
            diminishView,
            sheetView,
            boxOfficeLabel,
            collectionView,
            dailyWeeklyToggle
        )
    }
    
    private func setupConstraints() {
        
        // MARK: - backgroundImage
        backgroundImage.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            backgroundImage.topAnchor.constraint(equalTo: topAnchor),
            backgroundImage.leadingAnchor.constraint(equalTo: leadingAnchor),
            backgroundImage.trailingAnchor.constraint(equalTo: trailingAnchor),
            backgroundImage.heightAnchor.constraint(equalToConstant: 600)
        ])
        
        // MARK: - diminishView
        diminishView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            diminishView.topAnchor.constraint(equalTo: backgroundImage.topAnchor),
            diminishView.leadingAnchor.constraint(equalTo: backgroundImage.leadingAnchor),
            diminishView.trailingAnchor.constraint(equalTo: backgroundImage.trailingAnchor),
            diminishView.bottomAnchor.constraint(equalTo: backgroundImage.bottomAnchor)
            
        ])
        
        // MARK: - sheetView
        sheetView.translatesAutoresizingMaskIntoConstraints = false
        sheetView.layer.cornerRadius = 50
        sheetView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        sheetView.layer.masksToBounds = true
        
        NSLayoutConstraint.activate([
            sheetView.topAnchor.constraint(equalTo: topAnchor, constant: 280),
            sheetView.leadingAnchor.constraint(equalTo: leadingAnchor),
            sheetView.trailingAnchor.constraint(equalTo: trailingAnchor),
            sheetView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        // MARK: - boxOfficeLabel
        boxOfficeLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            boxOfficeLabel.topAnchor.constraint(equalTo: sheetView.topAnchor, constant: 40),
            boxOfficeLabel.leadingAnchor.constraint(equalTo: sheetView.leadingAnchor, constant: 30),
            boxOfficeLabel.trailingAnchor.constraint(equalTo: sheetView.trailingAnchor, constant: -10),
        ])
        
        // MARK: - collectionView
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: boxOfficeLabel.bottomAnchor, constant: 30),
            collectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            collectionView.bottomAnchor.constraint(equalTo: dailyWeeklyToggle.topAnchor, constant: -30)
        ])
        
        // MARK: - dailyWeeklyToggle
        dailyWeeklyToggle.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dailyWeeklyToggle.topAnchor.constraint(equalTo: bottomAnchor, constant: -100),
            dailyWeeklyToggle.leadingAnchor.constraint(equalTo: leadingAnchor),
            dailyWeeklyToggle.trailingAnchor.constraint(equalTo: trailingAnchor),
            dailyWeeklyToggle.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension MainView {
    private func configureFlowLayout() -> UICollectionViewFlowLayout {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumInteritemSpacing = BoxOfficeConstraint.minimumInteritemSpacing
        flowLayout.itemSize.width = (BoxOfficeConstraint.deviceWidth
                                     - BoxOfficeConstraint.minimumInteritemSpacing) / 2.5
        flowLayout.itemSize.height = 330
        flowLayout.sectionInset = BoxOfficeConstraint.inset
        flowLayout.scrollDirection = .horizontal
        return flowLayout
    }
}
