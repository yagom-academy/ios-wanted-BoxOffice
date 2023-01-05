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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(movieDetailView)
        view.backgroundColor = .white
        self.title = detailViewContent?.boxOfficeInfo.movieNm
        
        NSLayoutConstraint.activate([
            movieDetailView.leadingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.leadingAnchor),
            movieDetailView.topAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.topAnchor),
            movieDetailView.trailingAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.trailingAnchor),
            movieDetailView.bottomAnchor.constraint(equalTo: self.view.safeAreaLayoutGuide.bottomAnchor)
        ])

        guard let data = detailViewContent else {
            return
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
        guard let content = detailViewContent else {
            return
        }
        
        let age = content.movieInfo.audits.first?.watchGradeNm.filter({ $0.isNumber }) ?? ""
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

        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.movieDetailView.setPoster(image: image, age: age, color: color)
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
