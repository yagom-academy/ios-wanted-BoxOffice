//
//  PlotCell2.swift
//  BoxOffice
//
//  Created by sole on 2022/10/20.
//

import UIKit

final class PlotCell2: UICollectionViewCell {
//    private let vStackView: UIStackView = {
//        let view = UIStackView()
//        view.translatesAutoresizingMaskIntoConstraints = false
//        view.axis = .vertical
//        view.spacing = 5
//        view.alignment = .fill
//        view.distribution = .fill
//        view.contentMode = .scaleAspectFit
//        view.backgroundColor = .blue
//        return view
//    }()
    
    private let plotLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let openAndCloseLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configureHierarchy()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        plotLabel.text = nil
        plotLabel.numberOfLines = 1
        openAndCloseLabel.text = "...더보기"
    }
    
    func configure(with mockData: PlotInfo) {
        plotLabel.text = mockData.content
    }
    
    func appearanceLabel(isOpend: Bool) {
        switch isOpend {
        case true:
            plotLabel.numberOfLines = 0
            openAndCloseLabel.text = "접기"
        case false:
            plotLabel.numberOfLines = 1
            openAndCloseLabel.text = "...더보기"
        }
    }
    
    private func configureHierarchy() {
        [plotLabel, openAndCloseLabel].forEach { addSubview($0) }
//        addSubview(vStackView)
//        [plotLabel, openAndCloseLabel].forEach { vStackView.addArrangedSubview($0) }
        NSLayoutConstraint.activate([
//            vStackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
//            vStackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
//            vStackView.topAnchor.constraint(equalTo: contentView.topAnchor)
            plotLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            plotLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            plotLabel.topAnchor.constraint(equalTo: contentView.topAnchor),
            plotLabel.bottomAnchor.constraint(equalTo: openAndCloseLabel.topAnchor),

            openAndCloseLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            openAndCloseLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            openAndCloseLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
}
