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
            let averageScore = sumStar / count
            movieDetailView.starAverageLabel.text = String(format: "%.1f", averageScore)
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

    private func getLoginModel(index: Int) -> LoginModel {
        let data = FirebaseManager.shared.reviews[index]
        let model = LoginModel(
            image: data["image"] as? String ?? "",
            nickname: data["nickname"] as? String ?? "",
            password: data["password"] as? String ?? "",
            star: data["star"] as? Int ?? 1,
            content: data["content"] as? String ?? ""
        )
        return model
    }
    
    private func deleteReview(movieName: String, inputPassword: String, model: LoginModel) {
        if inputPassword == model.password {
            FirebaseManager.shared.delete(
                movieName: movieName,
                nickname: model.nickname
            )

            FirebaseManager.shared.fetch(movieName: movieName) { [weak self] _ in
                self?.cellCount = FirebaseManager.shared.reviews.count
                
                let alert = UIAlertController(title: "성공", message: "리뷰가 삭제되었습니다.", preferredStyle: .alert)
                let ok = UIAlertAction(title: "확인", style: .default)
                alert.addAction(ok)
                self?.present(alert, animated: true, completion: nil)
            }
        } else {
            let alert = UIAlertController(title: "실패", message: "비밀번호가 다릅니다.", preferredStyle: .alert)
            let ok = UIAlertAction(title: "확인", style: .default)
            alert.addAction(ok)
            
            self.present(alert, animated: true, completion: nil)
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

        let model = getLoginModel(index: indexPath.row)
        cell.setupReviewLabelText(model: model)
        cell.selectionStyle = .none
        cell.deleteButton.addAction(UIAction(handler: { [weak self] _ in
            var password = ""
            let alert = UIAlertController(
                title: "비밀번호를 입력해주세요.",
                message: "리뷰를 삭제하려면 비밀번호가 필요합니다.",
                preferredStyle: .alert
            )

            let cancel = UIAlertAction(title: "cancel", style: .cancel) { _ in
                
                return
            }

            let ok = UIAlertAction(title: "OK", style: .default) { [weak self] _ in
                
                self?.dismiss(animated: true)

                guard let movieName = self?.detailViewContent?.boxOfficeInfo.movieNm else {
                    return
                }
                
                password = alert.textFields?.first?.text ?? ""
                self?.deleteReview(
                    movieName: movieName,
                    inputPassword: password,
                    model: model
                )
            }
            
            alert.addTextField()
            alert.addAction(cancel)
            alert.addAction(ok)
            
            self?.present(alert, animated: true, completion: nil)
        }), for: .touchUpInside)
        
        return cell
    }
}
