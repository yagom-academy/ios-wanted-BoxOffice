//
//  DetailInfoViewController.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/04.
//

import UIKit
import Combine

final class DetailInfoViewController: UIViewController {
    
    private lazy var newLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.text = "NEW"
        label.textColor = UIColor(r: 76, g: 52, b: 145)
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.isHidden = true
        return label
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.textAlignment = .left
        label.numberOfLines = 0
        label.font = .preferredFont(forTextStyle: .title3)
        return label
    }()
    
    private lazy var infoLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .gray
        label.font = .preferredFont(forTextStyle: .subheadline)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var rankInfoLabel: UILabel =  {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var audienceLabel: UILabel =  {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var directorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var actorLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var dateLabel: UILabel = {
        let label = UILabel(frame: .zero)
        label.textColor = .black
        label.font = .preferredFont(forTextStyle: .body)
        label.numberOfLines = 1
        return label
    }()
    
    private lazy var shareButton: UIButton = {
        let button = UIButton(frame: .zero)
        button.addTarget(self, action: #selector(touchUpShareButton), for: .touchUpInside)
        button.setImage(UIImage(systemName: "paperplane"), for: .normal)
        button.tintColor = UIColor(r: 76, g: 52, b: 145)
        return button
    }()
    
    private var cancelable = Set<AnyCancellable>()
    private var detailInfoViewModel: DetailInfoViewModel?
        
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        bind()
        detailInfoViewModel?.input.onViewDidLoad()
        setup()
        setupConstraints()
    }
    
    static func instance(_ viewModel: DetailInfoViewModel) -> DetailInfoViewController {
        let viewController = DetailInfoViewController(nibName: nil, bundle: nil)
        viewController.detailInfoViewModel = viewModel
        return viewController
    }
    
    private func setup() {
        view.addSubviews(
        newLabel,
        titleLabel,
        infoLabel,
        rankInfoLabel,
        audienceLabel,
        directorLabel,
        actorLabel,
        dateLabel,
        shareButton
        )
    }
    
    private func setupConstraints() {
        // MARK: - newLabel
        newLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            newLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 20),
            newLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            newLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
        ])
        
        // MARK: - titleLabel
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: newLabel.bottomAnchor, constant: 5),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: shareButton.leadingAnchor, constant: -10)
        ])
        
        // MARK: - infoLabel
        infoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            infoLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5),
            infoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            infoLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
        // MARK: - rankInfoLabel
        rankInfoLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            rankInfoLabel.topAnchor.constraint(equalTo: infoLabel.bottomAnchor, constant: 20),
            rankInfoLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            rankInfoLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
        // MARK: - audienceLabel
        audienceLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            audienceLabel.topAnchor.constraint(equalTo: rankInfoLabel.bottomAnchor, constant: 5),
            audienceLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            audienceLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
        
        // MARK: - directorLabel
        directorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            directorLabel.topAnchor.constraint(equalTo: audienceLabel.bottomAnchor, constant: 5),
            directorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            directorLabel.trailingAnchor.constraint(equalTo: shareButton.trailingAnchor)
        ])
        
        // MARK: - actorLabel
        actorLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            actorLabel.topAnchor.constraint(equalTo: directorLabel.bottomAnchor, constant: 5),
            actorLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            actorLabel.trailingAnchor.constraint(equalTo: shareButton.trailingAnchor)
        ])
        
        // MARK: - dateLabel
        dateLabel.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            dateLabel.topAnchor.constraint(equalTo: actorLabel.bottomAnchor, constant: 5),
            dateLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            dateLabel.trailingAnchor.constraint(equalTo: shareButton.trailingAnchor)
        ])
        
        // MARK: - shareButton
        shareButton.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            shareButton.centerYAnchor.constraint(equalTo: titleLabel.centerYAnchor),
            shareButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            shareButton.widthAnchor.constraint(equalToConstant: 50),
            shareButton.heightAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    private func configureCustomBoxOffice(_ model: CustomBoxOffice) {
        let model = model.boxOffice
        rankInfoLabel.text = "순위: \(model.rank)   증감분: \(model.rankInTen)"
        audienceLabel.text = "관객수: \(model.audienceCount)명"
        if model.isNewRank == "NEW" {
            newLabel.isHidden = false
        }
    }
    
    private func configureDetailBoxOffice(_ model: DetailBoxOffice) {
        titleLabel.text = model.movieName
        infoLabel.text = " \(model.genre[0].genreName) | \(model.audits[0].watchGrade) | \(model.showTime)분"
        directorLabel.text = "감독: \(model.directors[0].peopleName ?? "")"
        actorLabel.text = "배우: \(model.actors?[0].peopleName ?? "")"
        dateLabel.text = "제작년도: \(model.productionYear)  개봉일: \(model.openDate)"
    }
    
    private func bind() {
        guard let detailInfoViewModel = detailInfoViewModel else { return }
                
        detailInfoViewModel.output.detailBoxOfficePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self = self else { return }
                self.configureDetailBoxOffice(model)
            }
            .store(in: &cancelable)
        
        detailInfoViewModel.output.customBoxOfficePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self = self else { return }
                self.configureCustomBoxOffice(model)
            }
            .store(in: &cancelable)
        
        detailInfoViewModel.output.shareMovieInfoPublisher
            .sink { [weak self] model in
                guard let self = self else { return }
                let activityController = UIActivityViewController(
                    activityItems: model,
                    applicationActivities: nil
                )
                self.present(activityController, animated: true)
            }
            .store(in: &cancelable)
    }
    
    @objc
    private func touchUpShareButton() {
        detailInfoViewModel?.input.touchUpShareButton()
    }
}
