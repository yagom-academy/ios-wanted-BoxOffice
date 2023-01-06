//
//  BoxOfficeListViewController.swift
//  BoxOffice
//
//  Created by YunYoungseo on 2023/01/02.
//

import UIKit

class BoxOfficeListViewController: UIViewController {
    private typealias DataSource = UICollectionViewDiffableDataSource<Section, BoxOfficeListCellViewModel>
    private typealias DataSourceSnapshot = NSDiffableDataSourceSnapshot<Section, BoxOfficeListCellViewModel>

    private var dataSource: DataSource? = nil
    private let listView: UICollectionView = {
        let configuration = UICollectionLayoutListConfiguration(appearance: .plain)
        let layout = UICollectionViewCompositionalLayout.list(using: configuration)
        let listView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        return listView
    }()
    private let dateIntervalStackView: UIStackView = {
        let descriptionLable = UILabel()
        descriptionLable.text = "조회 기간:"
        descriptionLable.setContentHuggingPriority(.defaultHigh, for: .horizontal)

        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = UIStackView.spacingUseSystem
        stackView.addArrangedSubview(descriptionLable)
        return stackView
    }()
    private let dateIntervalLabel: UILabel = {
        let label = UILabel()
        return label
    }()

    private let periodSegmentedControl = UISegmentedControl()
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        return stackView
    }()


    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "첫 화면"
        view.backgroundColor = .systemBackground
        setupSegmentControll()
        setupListView()
        layout()
        // initial data
        setupData(period: .day)
    }

    private func layout() {
        dateIntervalStackView.addArrangedSubview(dateIntervalLabel)

        view.addSubview(stackView)
        stackView.addArrangedSubview(periodSegmentedControl)
        stackView.addArrangedSubview(dateIntervalStackView)
        stackView.addArrangedSubview(listView)

        stackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            stackView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            stackView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            stackView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
        ])
    }

    private func setupData(period: Period) {
        typealias Request = BoxOfficeListRequester.BoxOfficeListRequest

        let reqester = BoxOfficeListRequester()
        let calendar = Calendar.current
        let yesterday = calendar.date(byAdding: .day, value: -1, to: Date())
        let lastWeek = calendar.date(byAdding: .day, value: -7, to: Date())

        switch period {
        case .day:
            reqester.requestDailyList(Request(targetDt: yesterday ?? Date()), completionHandler: completionHandler(result:))
        case .week:
            reqester.requestWeeklyList(Request(targetDt: lastWeek ?? Date(), weekGb: .week), completionHandler: completionHandler(result:))
        case .weekend:
            reqester.requestWeeklyList(Request(targetDt: lastWeek ?? Date(), weekGb: .weekend), completionHandler: completionHandler(result:))
        case .weekdays:
            reqester.requestWeeklyList(Request(targetDt: lastWeek ?? Date(), weekGb: .weekdays), completionHandler: completionHandler(result:))
        }

        func completionHandler(result: Result<KobisResult, Error>) {
            switch result {
            case .success(let kobisResult):
                self.apply(kobisResult)
            case .failure(let error):
                print(error.localizedDescription)
                return
            }
        }
    }

    private func apply(_ result: KobisResult) {
        let movies = result.boxOfficeList.movies.map{ BoxOfficeListCellViewModel(boxOffice: $0) }

        var snapshot = DataSourceSnapshot()
        snapshot.appendSections([.main])
        snapshot.appendItems(movies)
        DispatchQueue.main.async { [weak self] in
            let dateFormatter = ISO8601DateFormatter()
            dateFormatter.timeZone = TimeZone(identifier: "Asia/Seoul")
            dateFormatter.formatOptions = .withFullDate

            let dateInterval = result.boxOfficeList.showRange
            let startDate = dateFormatter.string(from: dateInterval.start)
            let endDate = dateFormatter.string(from: dateInterval.end)

            self?.dateIntervalLabel.text = "\(startDate)~\(endDate)"
            self?.dataSource?.apply(snapshot, animatingDifferences: false)
        }
    }

    private func setupSegmentControll() {
        let daySegment = UIAction(title: Period.day.title) { [weak self] _ in
            self?.setupData(period: .day)
        }
        periodSegmentedControl.insertSegment(action: daySegment, at: 0, animated: false)

        let weekSegment = UIAction(title: Period.week.title) { [weak self] _ in
            self?.setupData(period: .week)
        }
        periodSegmentedControl.insertSegment(action: weekSegment, at: 1, animated: false)

        let weekendSegmant = UIAction(title: Period.weekend.title) { [weak self] _ in
            self?.setupData(period: .weekdays)
        }
        periodSegmentedControl.insertSegment(action: weekendSegmant, at: 2, animated: false)

        periodSegmentedControl.selectedSegmentIndex = 0
    }

    private func setupListView() {
        let cellRegistraion = UICollectionView.CellRegistration<BoxOfficeListCell, BoxOfficeListCellViewModel> { cell, indexPath, item in
            cell.viewModel = item
            cell.indentationWidth = 10
            cell.indentationLevel = 1
        }

        dataSource = DataSource(collectionView: listView) { collectionView, indexPath, item in
            return collectionView.dequeueConfiguredReusableCell(using: cellRegistraion, for: indexPath, item: item)
        }

        listView.dataSource = dataSource
        listView.delegate = self
    }
}

extension BoxOfficeListViewController {
    private enum Section: CaseIterable {
        case main
    }

    private enum Period: CaseIterable {
        case day
        case week
        case weekend
        case weekdays

        var title: String {
            switch self {
            case .day:
                return "일"
            case .week:
                return "주"
            case .weekend:
                return "주말"
            case .weekdays:
                return "주중"
            }
        }
    }
}

extension BoxOfficeListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        guard let cell = cell as? BoxOfficeListCell else { return }
        
        guard let boxOffice = cell.viewModel?.boxOffice else { return }
        let secondViewController = SecondViewController(boxOffice: boxOffice)
        navigationController?.pushViewController(secondViewController, animated: true)
    }
}
