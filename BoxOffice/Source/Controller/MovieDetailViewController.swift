//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/02.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private var detailViewContent: MovieModel?
    private let movieDetailView = MovieDetailView()
    private var cellCount = 0 {
        didSet {
            self.movieDetailView.reviewTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(movieDetailView)
        view.backgroundColor = .white
        self.title = detailViewContent?.boxOfficeInfo.movieNm
        
        movieDetailView.reviewTableView.delegate = self
        movieDetailView.reviewTableView.dataSource = self
        movieDetailView.reviewTableView.register(
            ReviewTableViewCell.self,
            forCellReuseIdentifier: "ReviewTableViewCell"
        )
        
        NSLayoutConstraint.activate([
            movieDetailView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            movieDetailView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            movieDetailView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            movieDetailView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        guard let data = detailViewContent else {
            return
        }
        
        FirebaseManager.shared.fetch(movieName: data.boxOfficeInfo.movieNm) { _ in
            print(FirebaseManager.shared.reviews)
            self.cellCount = FirebaseManager.shared.reviews.count
        }

        movieDetailView.setLabelText(data)
        movieDetailView.shareButton.addTarget(
            self,
            action: #selector(didTapShareButton),
            for: .touchUpInside
        )
        
        movieDetailView.reviewButton.addTarget(
            self,
            action: #selector(didTapReviewButton),
            for: .touchUpInside
        )
        setPostLabel()
        addStackView()
        
    }
    
    private func setPostLabel() {
        guard let content = detailViewContent,
              let grade = content.movieInfo.audits.first?.watchGradeNm else {
            return
        }
        
        var age = grade.filter({ $0.isNumber })
        
        if age == "" {
            age = "ALL"
        }
        
        var color = UIColor.green

        switch age {
        case "12":
            color = UIColor.yellow
        case "15":
            color = UIColor.orange
        case "18":
            color = UIColor.red
        default:
            color = UIColor.green
        }
        
        guard let posterURL = content.posterURL,
              let url = URL(string: posterURL) else {
            return
        }

        if let cachedImage = ImageCacheManager.shared.getCachedImage(
            url: NSString(string: posterURL)
        ) {
            DispatchQueue.main.async { [weak self] in
                self?.movieDetailView.setPoster(
                    image: cachedImage,
                    age: age,
                    color: color
                )
            }
            return
        }
        
        
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.movieDetailView.setPoster(
                            image: image,
                            age: age,
                            color: color
                        )
                    }
                }
            }
        }
    }
    
    private func addStackView() {
        guard let content = detailViewContent else {
            return
        }
        
        if content.movieInfo.directors.count != 0 {
            for num in (0..<content.movieInfo.directors.count) {
                movieDetailView.addDirectorAndActorLabel(
                    name: content.movieInfo.directors[num].peopleNm,
                    role: "감독")
            }
        }
        
        if content.movieInfo.actors.count != 0 {
            for num in (0..<content.movieInfo.actors.count) {
                movieDetailView.addDirectorAndActorLabel(
                    name: content.movieInfo.actors[num].peopleNm,
                    role: content.movieInfo.actors[num].cast)
            }
        }
    }
    
    @objc private func didTapShareButton() {
        guard let data = detailViewContent else {
            return
        }
        
        var shareItems = [String]()
        shareItems.append(movieDetailView.titleLabel.text ?? data.boxOfficeInfo.movieNm)
        shareItems.append(movieDetailView.genreLabel.text ?? (data.movieInfo.genres.first?.genreNm ?? ""))
        shareItems.append(movieDetailView.runtimeLabel.text ?? data.movieInfo.showTm)
        shareItems.append(movieDetailView.ratingNameLabel.text ?? (data.movieInfo.audits.first?.watchGradeNm ?? ""))
        
        let activityViewController = UIActivityViewController(activityItems: shareItems, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = self.view
        self.present(activityViewController, animated: true, completion: nil)
    }
    
    @objc private func didTapReviewButton() {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(
            loginViewController,
            animated: true
        )
    }
}

extension MovieDetailViewController: SendDataDelegate {
    func sendData<T>(_ data: T) {
        guard let content = data as? MovieModel else {
            return
        }
        
        detailViewContent = content
    }
}

extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: "ReviewTableViewCell",
            for: indexPath
        ) as? ReviewTableViewCell else {
            return UITableViewCell()
        }
        
        return cell
    }
}
