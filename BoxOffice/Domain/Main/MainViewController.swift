//
//  MainViewController.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/03.
//

import UIKit
import Combine

final class MainViewController: UIViewController, UICollectionViewDelegate {
    
    typealias DataSource = UICollectionViewDiffableDataSource<Section, Row>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, Row>
    
    enum Section: Hashable {
        case dailyBoxOffice
    }
    
    enum Row: Hashable {
        case forDailyBoxOffice(entity: CustomBoxOffice)
    }
    
    private let mainView = MainView(frame: .zero)
    private var mainViewModel: MainViewModelInterface?
    private lazy var dataSource = createDataSource()
    private var cancelable = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view = mainView
        mainViewModel?.input.onViewDidLoad()
        mainView.collectionView.delegate = self
        bind()
    }
    
    static func instance(_ viewModel: MainViewModelInterface) -> MainViewController {
        let viewController = MainViewController(nibName: nil, bundle: nil)
        viewController.mainViewModel = viewModel
        return viewController
    }
    
    private func bind() {
        guard let mainViewModel = mainViewModel else { return }
        
        mainViewModel.output.boxOfficePublisher
            .receive(on: DispatchQueue.main)
            .sink { [weak self] model in
                guard let self = self else { return }
                self.applySnapshot(models: model)
            }
            .store(in: &cancelable)
        
        mainViewModel.output.detailBoxOfficePublisher
            .sink { [weak self] model in
                guard let self = self else { return }
                self.navigationController?.pushViewController(
                    DetailViewController.instance(
                        DetailViewModel(detailBoxOffice: model),
                                                  model: model),
                    animated: true
                )
            }
            .store(in: &cancelable)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        mainViewModel?.input.didSelectRowAt(indexPath[1])
    }
}

extension MainViewController {
    
    private func createDataSource() -> DataSource {
        let datasource = DataSource(collectionView: mainView.collectionView) { collectionView, indexPath, itemIdentifier in
            switch itemIdentifier {
            case .forDailyBoxOffice(let entity):
                guard let cell = collectionView.dequeueReusableCell(
                    withReuseIdentifier: MainViewCell.identifier,
                    for: indexPath
                ) as? MainViewCell else { return UICollectionViewCell() }
                cell.configureCell(entity)
                return cell
            }
        }
        return datasource
    }
    
    
    private func applySnapshot(models: [CustomBoxOffice]) {
        var snapshot = Snapshot()
        
        if models.isEmpty == false {
            snapshot.appendSections([.dailyBoxOffice])
        }
        
        snapshot.sectionIdentifiers.forEach { section in
            switch section {
            case .dailyBoxOffice:
                let row = models.map { Row.forDailyBoxOffice(entity: $0) }
                snapshot.appendItems(row, toSection: .dailyBoxOffice)
            }
            dataSource.apply(snapshot)
        }
    }
}

