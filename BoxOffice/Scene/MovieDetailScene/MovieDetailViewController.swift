//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/04.
//

import UIKit

final class MovieDetailViewController: UIViewController {
    private let entireStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 0
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let reviewTableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ReviewTableViewCell.self,
                           forCellReuseIdentifier: ReviewTableViewCell.identifier)
        return tableView
    }()

    private lazy var movieReviewView = MovieReviewView(tableView: reviewTableView)
    private let movieMainInfoView = MovieMainInfoView()
    private let movieSubInfoView = MovieSubInfoView()
    private let reviewViewModel = MovieReviewViewModel()
    private let movieDetail: MovieData
    
    init(movieDetail: MovieData) {
        self.movieDetail = movieDetail
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadReview()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupNavigationItem()
        bind()
    }
    
    private func loadReview() {
        let movieKey = movieDetail.title + movieDetail.openYear
        reviewViewModel.fetch(at: movieKey)
    }
    
    private func bind() {
        reviewViewModel.reviews.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.reviewTableView.reloadData()
            }
        }
        
        reviewViewModel.error.bind { [weak self] error in
            DispatchQueue.main.async {
                if let description = error {
                    self?.showAlert(message: description)
                }
            }
        }
    }
}

//MARK: Review TableView
extension MovieDetailViewController: UITableViewDataSource {
    private func setupTableView() {
        reviewTableView.dataSource = self
        reviewTableView.rowHeight = view.bounds.height * 0.1
        reviewTableView.isScrollEnabled = false
        reviewTableView.allowsSelection = false
    }
    
    private func setupInitialTableView() {
        let emptyLabel = UILabel()
        emptyLabel.frame = CGRect(x: .zero, y: .zero, width: view.bounds.width, height: view.bounds.height)
        emptyLabel.text = "작성된 리뷰가 없습니다."
        emptyLabel.textAlignment = .center
        reviewTableView.backgroundView = emptyLabel
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let reviewCount = reviewViewModel.reviews.value.count
        reviewTableView.backgroundView = .none
        
        guard reviewCount != 0 else {
            setupInitialTableView()
            return 0
        }
        
        if reviewCount > 3 {
            movieReviewView.moreButtonState(isEnabled: true)
            return 3
        } else{
            movieReviewView.moreButtonState(isEnabled: false)
            return reviewCount
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier,
                                                       for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        let review = reviewViewModel.reviews.value[indexPath.row]
        cell.configure(with: review)
        cell.addTargetDeleteButton(with: self,
                                   selector: #selector(reviewDeleteButtonTapped),
                                   tag: indexPath.row)
        return cell
    }
}

//MARK: Setup View
extension MovieDetailViewController {
    private func setupView() {
        movieMainInfoView.configure(with: movieDetail)
        movieSubInfoView.configure(with: movieDetail)

        addSubView()
        setupTableView()
        setupConstraint()
        addTagetButton()
        view.backgroundColor = .systemBackground
    }
    
    private func addSubView() {
        entireStackView.addArrangedSubview(movieMainInfoView)
        entireStackView.addArrangedSubview(movieSubInfoView)
        entireStackView.addArrangedSubview(movieReviewView)
        
        view.addSubview(entireStackView)
    }
    
    private func setupConstraint() {
        NSLayoutConstraint.activate([
            entireStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            entireStackView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            entireStackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            entireStackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            movieMainInfoView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor,
                                                      multiplier: 1/3),
            movieReviewView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor,
                                                    multiplier: 5/10)
        ])
    }
}

//MARK: Button Action
extension MovieDetailViewController {
    private func addTagetButton() {
        movieSubInfoView.addTargetMoreButton(with: self,
                                             selector: #selector(moreActorButtonTapped))
        movieReviewView.addTargetWriteButton(with: self,
                                             selector: #selector(writeReviewButtonTapped))
        movieReviewView.addTargetMoreButton(with: self,
                                            selector: #selector(moreReviewButtonTapped))
    }
    
    @objc private func moreActorButtonTapped() {
        //TODO: 배우 더보기 modal
        let actorList = movieDetail.actors
        let actorListViewController = ActorListViewController(actorList: actorList)
        present(actorListViewController, animated: true)
    }
    
    @objc private func writeReviewButtonTapped() {
        let writeReviewViewController = WriteReviewViewController(movie: movieDetail)
        navigationController?.pushViewController(writeReviewViewController,
                                                 animated: true)
    }
    
    @objc private func moreReviewButtonTapped() {
        let reviewListViewController = ReviewListViewController(movie: movieDetail,
                                                                 viewModel: reviewViewModel)
        navigationController?.pushViewController(reviewListViewController,
                                                 animated: true)
    }
    
    @objc func reviewDeleteButtonTapped(button: UIButton) {
        let review = reviewViewModel.reviews.value[button.tag]
        let checkPasswordAlert = UIAlertController(title: "리뷰 삭제",
                                                   message: "암호를 입력해주세요.",
                                                   preferredStyle: .alert)
        checkPasswordAlert.addTextField()
        
        let confirmAction = UIAlertAction(title: "확인", style: .default) { [self] _ in
            let inputPassword = checkPasswordAlert.textFields?.first?.text
            if inputPassword == review.password {
                reviewViewModel.delete(review,
                                       at: movieDetail.title + movieDetail.openYear)
            } else {
                showAlert(title: "리뷰 삭제 실패",
                          message: "암호가 일치하지 않습니다.")
            }
        }
        
        checkPasswordAlert.addAction(confirmAction)
        checkPasswordAlert.addAction(UIAlertAction(title: "취소",
                                                   style: .cancel))
        present(checkPasswordAlert, animated: true)
    }
}

//MARK: Setup NavigationItem
extension MovieDetailViewController {
    private func setupNavigationItem() {
        let shareBarButton = UIBarButtonItem(image: UIImage(systemName: "square.and.arrow.up"),
                                             style: .plain,
                                             target: self,
                                             action: #selector(shareButtonTapped))
        
        navigationItem.rightBarButtonItem = shareBarButton
        navigationItem.title = movieDetail.title
    }
    
    @objc private func shareButtonTapped() {
        let shareObject: [String] = convertMovieInfo()
        let activityViewController = UIActivityViewController(activityItems: shareObject,
                                                              applicationActivities: nil)
        
        present(activityViewController, animated: true)
    }
    
    private func convertMovieInfo() -> [String] {
        let movieInfo = [movieDetail.title,
                         movieDetail.openYear + " 개봉",
                         movieDetail.ageLimit,
                         movieDetail.currentRank + "위",
                         movieDetail.directorName,
                         movieDetail.actors.joined(separator: ","),
                         movieDetail.genreName,
                         movieDetail.isNewEntry ? "순위 진입" : "",
                         movieDetail.openDate,
                         movieDetail.rankChange + "단계 변동",
                         movieDetail.showTime + "분"
        ]
        
        return movieInfo
    }
}


