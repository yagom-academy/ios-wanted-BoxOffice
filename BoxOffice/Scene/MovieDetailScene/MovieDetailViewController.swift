//
//  MovieDetailViewController.swift
//  BoxOffice
//
//  Created by Judy on 2023/01/04.
//

import UIKit

class MovieDetailViewController: UIViewController {
    private let reviewTitleLabel = MovieLabel(font: .title3, isBold: true)
    private let writeReviewButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(systemName: "pencil"), for: .normal)
        button.setTitle("리뷰 작성하기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let moreReviewButton: UIButton = {
        let button = UIButton()
        button.setTitle("더보기", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.borderColor = UIColor.systemGray5.cgColor
        button.layer.borderWidth = 2
        return button
    }()
    
    private let reviewStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 8
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private let reviewTitleStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
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
                           forCellReuseIdentifier: "ReviewTableViewCell")
        return tableView
    }()

    private let movieMainInfoView = MovieMainInfoView()
    private let movieSubInfoView = MovieSubInfoView()
    private let reviewViewModel = MovieReviewViewModel()
    
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
    
    let testMovie = MovieDetail(
        currentRank: "1",
        title: "오펀: 천사의 탄생",
        openDate: "20221012",
        totalAudience: "50243",
        rankChange: "-3",
        isNewEntry: true,
        productionYear: "2022",
        openYear: "2022",
        showTime: "146",
        genreName: "공포(호러)",
        directorName: "윌리엄 브렌트 벨",
        actors: "이사벨 퍼만, 줄리아 스타일즈, 로지프 서덜랜드",
        ageLimit: "15세 이상 관람가"
    )
    
    //TODO: 이전 페이지에서 데이터 받아오기 (뷰모델에서 가저오면 될듯합니다)
    //TODO: 출연 더보기 모달 뷰
    
    private func loadReview() {
        reviewViewModel.fetch()
    }
    
    private func bind() {
        reviewViewModel.reviews.bind { [weak self] _ in
            DispatchQueue.main.async {
                self?.reviewTableView.reloadData()
            }
        }
    }
}

//MARK: Review TableView
extension MovieDetailViewController: UITableViewDataSource {
    private func setupTableView() {
        reviewTableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let reviewCount = reviewViewModel.reviews.value.count
        
        return reviewCount > 3 ? 3 : reviewCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewTableViewCell.identifier,
                                                       for: indexPath) as? ReviewTableViewCell else { return UITableViewCell() }
        let review = reviewViewModel.reviews.value[indexPath.row]
        cell.configure(with: review)
        
        return cell
    }
}

//MARK: Setup View
extension MovieDetailViewController {
    private func setupView() {
        //TODO: ReviewTable
        movieMainInfoView.configure(with: testMovie)
        movieSubInfoView.configure(with: testMovie)
        reviewTitleLabel.text = "리뷰"
        
        addSubView()
        setupConstraint()
        setupTableView()
        view.backgroundColor = .systemBackground
    }
    
    private func addSubView() {
        reviewTitleStackView.addArrangedSubview(reviewTitleLabel)
        reviewTitleStackView.addArrangedSubview(writeReviewButton)
        
        reviewStackView.addArrangedSubview(reviewTitleStackView)
        reviewStackView.addArrangedSubview(reviewTableView)
        reviewStackView.addArrangedSubview(moreReviewButton)
        
        entireStackView.addArrangedSubview(movieMainInfoView)
        entireStackView.addArrangedSubview(movieSubInfoView)
        entireStackView.addArrangedSubview(reviewStackView)
        
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
            reviewStackView.heightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.heightAnchor,
                                                    multiplier: 5/10),
            
            reviewStackView.bottomAnchor.constraint(equalTo: entireStackView.bottomAnchor,
                                                    constant: -8),
            reviewStackView.leadingAnchor.constraint(equalTo: entireStackView.leadingAnchor,
                                                     constant: 16),
            reviewStackView.trailingAnchor.constraint(equalTo: entireStackView.trailingAnchor,
                                                      constant: -16),
        ])
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
        //TODO: 넘겨받은 영화 제목으로 설정
        navigationItem.title = testMovie.title
    }
    
    @objc private func shareButtonTapped() {
        //TODO: 영화정보 공유하기
    }
}
