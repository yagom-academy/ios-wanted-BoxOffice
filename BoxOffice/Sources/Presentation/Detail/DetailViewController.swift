//
//  DetailViewController.swift
//  BoxOffice
//
//  Created by 이예은 on 2023/01/03.
//

import UIKit
import Combine

class DetailViewController: UIViewController {
    
    weak var coordinator: BoxOfficeListCoordinatorInterface?
    private let viewModel: MovieDetailViewModel
    private var cancelable = Set<AnyCancellable>()
    private let tableView: UITableView = {
        let tableView = UITableView()
        
        tableView.backgroundColor = .boBackground
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.separatorColor = .gray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 15, bottom: 0, right: 15)
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bind()
        self.view.backgroundColor = .boBackground
        self.view.addSubview(tableView)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(FirstCell.self, forCellReuseIdentifier: "FirstCell")
        tableView.register(SecondCell.self, forCellReuseIdentifier: "SecondCell")
        tableView.register(ThirdCell.self, forCellReuseIdentifier: "ThirdCell")
        tableView.register(ReviewCell.self, forCellReuseIdentifier: "ReviewCell")
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])

        navigationItem.largeTitleDisplayMode = .never
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        viewModel.input.viewWillAppear()
    }

    init(viewModel: MovieDetailViewModel, coordinator: BoxOfficeListCoordinatorInterface) {
        self.viewModel = viewModel
        self.coordinator = coordinator
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

private extension DetailViewController {
    func bind() {
        viewModel.movieModel
            .sink { [weak self] movieData in
                guard let self = self else {
                    return
                }
                
                print(self.viewModel._movie)
            }.store(in: &cancelable)
    }
    
    func setUpReviewButton(_ cell: ThirdCell) {
        cell.reviewButton.addTarget(self, action: #selector(didTapReviewButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapReviewButton(_ sender: UIButton) {
        coordinator?.showCreateReviewView(movie: viewModel.output.movie)
    }
    
    func setUpDeleteButton(_ cell: ReviewCell) {
        cell.deleteButton.addTarget(self, action: #selector(didTapDeleteButton(_:)), for: .touchUpInside)
    }
    
    @objc func didTapDeleteButton(_ sender: UIButton) {
    }
}

extension DetailViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.row {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: "FirstCell", for: indexPath) as! FirstCell
            cell.transferData(viewModel._movie.name, viewModel._movie.detailInfo!, viewModel._movie.boxOfficeInfo!)
            return cell
        case 1:
            let cell = tableView.dequeueReusableCell(withIdentifier: "SecondCell", for: indexPath) as! SecondCell
            cell.transferData(viewModel._movie.boxOfficeInfo!)
            return cell
        case 2:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ThirdCell", for: indexPath) as! ThirdCell
            setUpReviewButton(cell)
            cell.transferData(viewModel._movie.detailInfo!)
            return cell
        default:
            let cell = tableView.dequeueReusableCell(withIdentifier: "ReviewCell", for: indexPath) as! ReviewCell
            
            if let reviews = viewModel.reviews {
                cell.transferData(reviews, indexPath.row)
                return cell
            }
            
            setUpDeleteButton(cell)
            
            return cell
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
           return UITableView.automaticDimension
       }
}
