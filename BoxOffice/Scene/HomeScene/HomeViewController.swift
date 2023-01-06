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
    private var searchingDate: Date = Date()
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

    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialView()
        setupNavigationBar()
        setupCollectionView()
        setupButton()
        setupViewModel()
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
                self.homeCollectionView.reloadData()
            }
        }
        homeViewModel.allWeekMovieCellDatas.bind { cellDatas in
            guard cellDatas.count == 10 else { return }
            let rankSortedCellDatas = cellDatas.sorted { a, b in
                Int(a.currentRank) ?? 0 < Int(b.currentRank) ?? 0
            }
            DispatchQueue.main.async {
                self.homeCollectionView.appendAllWeekSnapshot(data: rankSortedCellDatas)
                self.homeCollectionView.reloadData()
            }
        }
        homeViewModel.weekEndMovieCellDatas.bind { cellDatas in
            guard cellDatas.count == 10 else { return }
            let rankSortedCellDatas = cellDatas.sorted { a, b in
                Int(a.currentRank) ?? 0 < Int(b.currentRank) ?? 0
            }
            DispatchQueue.main.async {
                self.homeCollectionView.appendWeekEndSnapshot(data: rankSortedCellDatas)
                self.homeCollectionView.reloadData()
            }
        }
        
        homeCollectionView.currentDate = searchingDate.toString()
        homeViewModel.requestDailyData(with: searchingDate.toString())
    }
    
    @objc private func viewModeChangeButtonTapped() {
        var modeText = viewModeChangeButton.currentTitle
        modeText?.removeFirst()
        modeText?.removeFirst()

        let modeSelectViewController = ModeSelectViewController(passMode: modeText ?? "")
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
        print(indexPath.row)
        // TODO: 영화 상세로 넘어가기

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
        let movieDetailViewController = MovieDetailViewController(movieDetail: testMovie)
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
    func didSelectedRowAt(indexPath: Int) {
        let mode = BoxOfficeMode.allCases[indexPath]
        viewModeChangeButton.setTitle("▼ \(mode.rawValue)", for: .normal)
        if mode == .daily {
            self.homeCollectionView.switchMode(.daily)
            homeViewModel.requestDailyData(with: searchingDate.toString())
        } else {
            self.homeCollectionView.switchMode(.weekly)
            homeViewModel.requestAllWeekData(with: searchingDate.toString())
            homeViewModel.requestWeekEndData(with: searchingDate.toString())
        }
    }
}

extension HomeViewController: CalendarViewControllerDelegate {
    func searchButtonTapped(date: Date) {
        searchingDate = date
        let dateText = date.toString()
        homeCollectionView.currentDate = dateText
        if viewModeChangeButton.title(for: .normal) == "▼ 일별 박스오피스" {
            homeViewModel.requestDailyData(with: dateText)
        } else {
            homeViewModel.requestAllWeekData(with: dateText)
            homeViewModel.requestWeekEndData(with: dateText)
        }
    }
}

// MARK: Setup Layout
private extension HomeViewController {
    func addSubviews() {
        view.addSubview(homeCollectionView)
        view.addSubview(viewModeChangeButton)
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
        ])
    }
}
