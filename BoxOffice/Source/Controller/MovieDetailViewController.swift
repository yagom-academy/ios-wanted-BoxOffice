//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by seohyeon park on 2023/01/02.
//

import UIKit

class MovieDetailViewController: UIViewController {
    // MARK: Properties
    private var detailViewContent: MovieModel?
    private let movieDetailView = MovieDetailView()
    private var cellCount = 0 {
        didSet {
            self.movieDetailView.reviewTableView.reloadData()
        }
    }
    
    // MARK: View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        configureTableView()
        configureUI()

        registerButtonAction()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        fetchReview()
    }
    
    // MARK: private function
    private func configureView() {
        view.addSubview(movieDetailView)
        view.backgroundColor = .white
        
        guard let content = detailViewContent else {
            return
        }

        self.title = content.boxOfficeInfo.movieNm
        movieDetailView.setLabelText(content)
        setPostLabel()
        addStackView()
    }
    
    private func configureTableView() {
        movieDetailView.reviewTableView.delegate = self
        movieDetailView.reviewTableView.dataSource = self
        movieDetailView.reviewTableView.register(
            ReviewTableViewCell.self,
            forCellReuseIdentifier: "ReviewTableViewCell"
        )
    }
    
    private func configureUI() {
        NSLayoutConstraint.activate([
            movieDetailView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            movieDetailView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            movieDetailView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            movieDetailView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
    private func registerButtonAction() {
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
    }
    
    private func fetchReview() {
        guard let data = detailViewContent else {
            return
        }
        
        FirebaseManager.shared.fetch(movieName: data.boxOfficeInfo.movieNm) { _ in
            self.cellCount = FirebaseManager.shared.reviews.count
            self.setStarScoreAverage()
        }
    }

    private func setStarScoreAverage() {
        var sumStar = 0.0
        var count = 0.0
        
        for data in FirebaseManager.shared.reviews {
            if let score = data["star"] as? Double {
                sumStar += score
                count += 1
            }
        }
        
        if sumStar == 0.0 {
            movieDetailView.starAverageLabel.text = "없음"
        } else {
            movieDetailView.starAverageLabel.text = String(sumStar / count)
        }
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
            self.movieDetailView.setPoster(
                image: UIImage(systemName: "play")!,
                age: age,
                color: color
            )
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
    
    // MARK: objc function
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
        weak var sendDataDelegate: (SendDataDelegate)? = loginViewController
        
        guard let movieName = detailViewContent?.boxOfficeInfo.movieNm else {
            return
        }
        sendDataDelegate?.sendData(movieName)

        navigationController?.pushViewController(
            loginViewController,
            animated: true
        )
    }
}

// MARK: Extension - SendDataDelegate
extension MovieDetailViewController: SendDataDelegate {
    func sendData<T>(_ data: T) {
        guard let content = data as? MovieModel else {
            return
        }
        
        detailViewContent = content
    }
}

// MARK: Extension - UITableViewDataSource, UITableViewDelegate
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
        
        let data = FirebaseManager.shared.reviews[indexPath.row]
        let model = LoginModel(
            image: data["image"] as? String ?? "",
            nickname: data["nickname"] as? String ?? "",
            password: data["password"] as? String ?? "",
            star: data["star"] as? Int ?? 1,
            content: data["content"] as? String ?? ""
        )

        cell.setupReviewLabelText(model: model)
        cell.selectionStyle = .none

        return cell
    }
}
