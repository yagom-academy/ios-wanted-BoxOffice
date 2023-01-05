//
//  HomeViewController.swift
//  BoxOffice
//
//  Created by kjs on 2022/10/14.
//

import UIKit

final class HomeViewController: UIViewController {
    private let selectList = ["일별 박스오피스", "주간/주말 박스오피스"]
    private let homeCollectionView = HomeCollectionView()
    private let homeViewModel = DefaultHomeViewModel()
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
        homeViewModel.movieCellDatas.bind { cellDatas in
            guard cellDatas.count == 10 else { return }
            let rankSortedCellDatas = cellDatas.sorted { a, b in
                Int(a.currentRank)! < Int(b.currentRank)!
            }
            DispatchQueue.main.async {
                self.homeCollectionView.appendSnapshot(with: rankSortedCellDatas)
                self.homeCollectionView.reloadData()
            }
        }
        homeViewModel.setupProperty(date: "20221004")
        homeCollectionView.currentDate = "20221004"
        homeViewModel.requestData()
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
        
        present(calendarViewController, animated: true)
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        // TODO: 영화 상세로 넘어가기
        print(indexPath.row)
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
        let mode = selectList[indexPath]
        viewModeChangeButton.setTitle("▼ \(mode)", for: .normal)
        // TODO: 해당 보기모드의 dataSource와 layout 으로 변경하기
    }
}

extension HomeViewController: CalendarViewControllerDelegate {
    func doneButtonDidTapped(date: String) {
        homeCollectionView.currentDate = date
        homeViewModel.setupProperty(date: date)
        homeViewModel.requestData()
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
