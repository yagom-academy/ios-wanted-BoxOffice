//
//  MoviesDetailViewController.swift
//  BoxOffice
//
//  Created by channy on 2022/10/22.
//

import UIKit
import MessageUI

class MoviesDetailViewController: UIViewController {
    
    var viewModel: MoviesDetailItemViewModel?
    var repository: MoviesRepository?
    
    lazy var moviesDetailTableView = MoviesDetailTableView()
    
    let activityIndicatorView: UIActivityIndicatorView = {
        let view = UIActivityIndicatorView(style: .medium)
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.color = .darkGray
        view.startAnimating()
        
        return view
    }()
    
    let shareButton: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemBlue
        view.layer.cornerRadius = 6
        view.tintColor = .white
        view.setTitle("공유하기", for: .normal)
        
        return view
    }()
    
    init(viewModel: MoviesDetailItemViewModel, repository: MoviesRepository) {
        self.viewModel = viewModel
        self.repository = repository
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.moviesDetailTableView.delegate = self
        self.moviesDetailTableView.dataSource = self
        
        fetchMovie()
        setupViews()
        setupConstraints()
        bind()
        setNavigationbar()
    }
}

extension MoviesDetailViewController {
    func setupViews() {
        let views = [moviesDetailTableView, shareButton, activityIndicatorView]
        views.forEach { self.view.addSubview($0) }
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            self.moviesDetailTableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.moviesDetailTableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.moviesDetailTableView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.moviesDetailTableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor)
        ])
        
        NSLayoutConstraint.activate([
            self.shareButton.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20),
            self.shareButton.trailingAnchor.constraint(equalTo: self.view.trailingAnchor, constant: -20),
            self.shareButton.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -40),
            self.shareButton.heightAnchor.constraint(equalTo: self.shareButton.widthAnchor, multiplier: 0.15)
        ])
        
        NSLayoutConstraint.activate([
            self.activityIndicatorView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            self.activityIndicatorView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            self.activityIndicatorView.topAnchor.constraint(equalTo: self.view.topAnchor),
            self.activityIndicatorView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
        ])
    }
    
    func bind() {
        self.shareButton.addTarget(self, action: #selector(shareButtonTapped), for: .touchUpInside)
    }
    
    func setNavigationbar() {
        self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }
}

extension MoviesDetailViewController {
    func fetchMovie() {
        self.repository?.fetchMoviesDetail(movieId: self.viewModel?.movieCd ?? "", completion: { response in
            switch response {
            case .success(let movieDetail):
                self.viewModel?.prdtYear = movieDetail.prdtYear
                self.viewModel?.showTm = movieDetail.showTm
                self.viewModel?.genreNm = movieDetail.genreNm
                self.viewModel?.directorsNm = movieDetail.directorsNm
                self.viewModel?.actorsNm = movieDetail.actorsNm
                self.viewModel?.watchGradeNm = movieDetail.watchGradeNm
                
                DispatchQueue.main.async {
                    self.activityIndicatorView.stopAnimating()
                    self.activityIndicatorView.isHidden = true
                    self.moviesDetailTableView.reloadData()
                }
                
            case .failure(_):
                print("FETCH ERROR")
            }
        })
    }
}

extension MoviesDetailViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch indexPath.section {
        case 0:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: FirstTableViewCell.identifier, for: indexPath) as? FirstTableViewCell else {
                return UITableViewCell()
            }
            
            cell.fill(viewModel: self.viewModel!)
            return cell
        case 1:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: SecondTableViewCell.identifier, for: indexPath) as? SecondTableViewCell else {
                return UITableViewCell()
            }
            
            cell.fill(viewModel: self.viewModel!)
            return cell
        case 2:
            guard let cell = tableView.dequeueReusableCell(withIdentifier: ThirdTableViewCell.identifier, for: indexPath) as? ThirdTableViewCell else {
                return UITableViewCell()
            }
            
            cell.fill(viewModel: self.viewModel!)
            return cell
        default:
            return UITableViewCell()
        }
    }
}

extension MoviesDetailViewController: MFMessageComposeViewControllerDelegate {
    @objc func shareButtonTapped() {
        guard let viewModel = self.viewModel else { return }
        let messageComposer = MFMessageComposeViewController()
                messageComposer.messageComposeDelegate = self
                if MFMessageComposeViewController.canSendText(){
                    messageComposer.body = """
                    \(viewModel.getRankString(viewModel.rank)) \(viewModel.movieNm)
                    
                    상세 정보
                    \(viewModel.getDateString(viewModel.openDt)), \(viewModel.getProduceDateString(viewModel.prdtYear)), \(viewModel.getShowTimeString(viewModel.showTm))
                    \(viewModel.getGenreString(viewModel.genreNm)), \(viewModel.getGradeString(viewModel.watchGradeNm))
                    누적 관객  \(viewModel.getAudienceString(viewModel.audiAcc))
                    
                    감독 및 배우
                    \(viewModel.getDirectorString(viewModel.directorsNm)) (감독)
                    \(viewModel.getActorString(viewModel.actorsNm)) (배우)
                    """
                    self.present(messageComposer, animated: true, completion: nil)
                }
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
            switch result {
            case MessageComposeResult.sent:
                print("전송 완료")
                break
            case MessageComposeResult.cancelled:
                print("취소")
                break
            case MessageComposeResult.failed:
                print("전송 실패")
                break
            @unknown default:
                fatalError("Message Error")
            }
            controller.dismiss(animated: true, completion: nil)
        }
}
