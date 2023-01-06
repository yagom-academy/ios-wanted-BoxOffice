//
//  HomeViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

enum BoxOfficeMode: String, CaseIterable {
    case daily = "일별 박스오피스"
    case weekly = "주간/주말 박스오피스"
}

final class HomeViewController: UIViewController {
    private let homeCollectionView = HomeCollectionView()
    private let homeViewModel = DefaultHomeViewModel()
    private var searchingDate: Date = Date().previousDate(to: -7)
    private let viewModeChangeButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("▼ 일별 박스오피스", for: .normal)
        button.titleLabel?.font = UIFont.preferredFont(forTextStyle: .callout)
        button.setTitleColor(.black, for: .normal)
        button.backgroundColor = .systemGray5
        button.contentHorizontalAlignment = .left
        return button
    }()
    private var viewMode: BoxOfficeMode {
        if viewModeChangeButton.currentTitle == "▼ 일별 박스오피스" {
            return BoxOfficeMode.daily
        } else {
            return BoxOfficeMode.weekly
        }
    }
    private let activityIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(frame: .zero)
        indicator.tintColor = .systemBlue
        indicator.style = .large
        indicator.hidesWhenStopped = true
        indicator.translatesAutoresizingMaskIntoConstraints = false
        return indicator
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupNavigationBar()
        setupCollectionView()
        setupButton()
        setupViewModel()
        Task {
            try await requestInitialData()
        }
        activityIndicator.startAnimating()
    }
    
    private func setupInitialView() {
        view.backgroundColor = .systemBackground
        addSubviews()
        setupConstraints()
    }
    
    private func setupNavigationBar() {
        navigationItem.title = "영화목록"
        let calendarButton = UIBarButtonItem(
            image: UIImage(systemName: "calendar"),
            style: .done,
            target: self,
            action: #selector(calendarButtonTapped)
        )
        navigationItem.rightBarButtonItem = calendarButton
    }
    
    private func setupCollectionView() {
        homeCollectionView.translatesAutoresizingMaskIntoConstraints = false
        homeCollectionView.delegate = self
        homeCollectionView.register(
            HeaderView.self,
            forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader,
            withReuseIdentifier: "headerView"
        )
    }
    
    private func setupButton() {
        viewModeChangeButton.addTarget(
            self,
            action: #selector(viewModeChangeButtonTapped),
            for: .touchUpInside
        )
    }
    
    private func setupViewModel() {
        homeViewModel.dailyMovieCellDatas.bind { cellDatas in
            guard cellDatas.count == 10 else { return }
            let rankSortedCellDatas = cellDatas.sorted { a, b in
                Int(a.currentRank) ?? 0 < Int(b.currentRank) ?? 0
            }
            DispatchQueue.main.async {
                self.homeCollectionView.appendDailySnapshot(with: rankSortedCellDatas)
                self.activityIndicator.stopAnimating()
            }
        }
        homeViewModel.allWeekMovieCellDatas.bind { cellDatas in
            guard cellDatas.count == 10 else { return }
            let rankSortedCellDatas = cellDatas.sorted { a, b in
                Int(a.currentRank) ?? 0 < Int(b.currentRank) ?? 0
            }
            DispatchQueue.main.async {
                self.homeCollectionView.appendAllWeekSnapshot(data: rankSortedCellDatas)
                self.activityIndicator.stopAnimating()
            }
        }
        homeViewModel.weekEndMovieCellDatas.bind { cellDatas in
            guard cellDatas.count == 10 else { return }
            let rankSortedCellDatas = cellDatas.sorted { a, b in
                Int(a.currentRank) ?? 0 < Int(b.currentRank) ?? 0
            }
            DispatchQueue.main.async {
                self.homeCollectionView.appendWeekEndSnapshot(data: rankSortedCellDatas)
                self.activityIndicator.stopAnimating()
            }
        }
        
        homeCollectionView.currentDate = searchingDate.toString()
    }
    
    private func requestInitialData() async throws {
        try await homeViewModel.requestDailyData(with: searchingDate.toString())
    }
    
    @objc private func viewModeChangeButtonTapped() {
        let modeSelectViewController = ModeSelectViewController(passMode: viewMode)
        modeSelectViewController.delegate = self
        
        present(modeSelectViewController, animated: true)
    }
    
    @objc private func calendarButtonTapped() {
        let calendarViewController = CalendarViewController()
        calendarViewController.delegate = self
        calendarViewController.datePicker.date = searchingDate
        
        present(calendarViewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: 영화 상세로 넘어가기
        if viewMode == .daily {
            pushMovieDetail(
                in: homeViewModel.dailyMovieCellDatas.value,
                at: indexPath.row
            )
        } else {
            if indexPath.section == 0 {
                pushMovieDetail(
                    in: homeViewModel.allWeekMovieCellDatas.value,
                    at: indexPath.row
                )
            } else {
                pushMovieDetail(
                    in: homeViewModel.weekEndMovieCellDatas.value,
                    at: indexPath.row
                )
            }
        }
    }
    
    private func pushMovieDetail(in cellDatas: [MovieData], at index: Int) {
        let rankSortedCellDatas = cellDatas.sorted { a, b in
            Int(a.currentRank) ?? 0 < Int(b.currentRank) ?? 0
        }
        let tappedCellData = rankSortedCellDatas[index]
        let movieDetailViewController = MovieDetailViewController(movieDetail: tappedCellData)
        navigationController?.pushViewController(movieDetailViewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        referenceSizeForHeaderInSection section: Int) -> CGSize {
        let width = UIScreen.main.bounds.width
        let height = UIScreen.main.bounds.height / 10
        return CGSize(width: width, height: height)
    }
}

// MARK: ModalView Delegate
extension HomeViewController: ModeSelectViewControllerDelegate {
    func didSelectedRowAt(indexPath: Int) async throws {
        activityIndicator.startAnimating()
        let mode = BoxOfficeMode.allCases[indexPath]
        viewModeChangeButton.setTitle("▼ \(mode.rawValue)", for: .normal)
        let dateText = searchingDate.toString()
        if mode == .daily {
            self.homeCollectionView.switchMode(.daily)
            try await homeViewModel.requestDailyData(with: dateText)
        } else {
            self.homeCollectionView.switchMode(.weekly)
            Task {
                try await homeViewModel.requestAllWeekData(with: dateText)
            }
            Task {
                try await homeViewModel.requestWeekEndData(with: dateText)
            }
        }
    }
}

extension HomeViewController: CalendarViewControllerDelegate {
    func searchButtonTapped(date: Date) async throws {
        activityIndicator.startAnimating()
        searchingDate = date
        let dateText = date.toString()
        homeCollectionView.currentDate = dateText
        if viewModeChangeButton.title(for: .normal) == "▼ 일별 박스오피스" {
            self.homeCollectionView.switchMode(.daily)
            try await homeViewModel.requestDailyData(with: dateText)
        } else {
            self.homeCollectionView.switchMode(.weekly)
            Task {
                try await homeViewModel.requestAllWeekData(with: dateText)
            }
            Task {
                try await homeViewModel.requestWeekEndData(with: dateText)
            }
        }
    }
}

// MARK: Setup Layout
private extension HomeViewController {
    func addSubviews() {
        view.addSubview(homeCollectionView)
        view.addSubview(viewModeChangeButton)
        view.addSubview(activityIndicator)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            viewModeChangeButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            viewModeChangeButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            viewModeChangeButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            viewModeChangeButton.heightAnchor.constraint(equalToConstant: 30),
            
            homeCollectionView.topAnchor.constraint(equalTo: viewModeChangeButton.bottomAnchor),
            homeCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
            homeCollectionView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            homeCollectionView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            
            activityIndicator.widthAnchor.constraint(equalToConstant: 40),
            activityIndicator.heightAnchor.constraint(equalToConstant: 40),
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor),
        ])
    }
}
