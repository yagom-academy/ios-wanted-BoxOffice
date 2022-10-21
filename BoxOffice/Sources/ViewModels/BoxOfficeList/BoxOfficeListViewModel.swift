//
//  BoxOfficeListViewModel.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/19.
//

import Foundation
import UIKit
import Combine

class BoxOfficeListViewModel {
    // MARK: Input
    let selectItem = PassthroughSubject<Int, Never>()
    
    // MARK: Output
    @Published var cellModels = [BoxOfficeListCollectionViewCellModel]()
    @Published var filter: BoxOfficeFilter = .weekend
    let viewAction = PassthroughSubject<ViewAction, Never>()
    
    // MARK: Properties
    let repository = Repository()
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init() {
        bind()
    }
    
    // MARK: Binding
    func bind() {
        $filter
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] _ in
                guard let self else { return }
                self.cellModels = []
            })
            .flatMap { [weak self] filter -> AnyPublisher<[Movie], Error> in
                guard let self else { return Empty().eraseToAnyPublisher() }
                switch filter {
                case .daily:
                    return self.repository.dailyBoxOffice(Date.yesterDay.toString(.yyyyMMdd))
                case .weekend:
                    return self.repository.weeklyBoxOffice(Date.lastWeek.toString(.yyyyMMdd), weekGb: .weekend)
                case .weekday:
                    return self.repository.weeklyBoxOffice(Date.lastWeek.toString(.yyyyMMdd), weekGb: .weekday)
                case .weekly:
                    return self.repository.weeklyBoxOffice(Date.lastWeek.toString(.yyyyMMdd), weekGb: .weekly)
                }
            }.map { $0.map { BoxOfficeListCollectionViewCellModel(movie: $0) } }
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    debugPrint("😡Error Occured While Loading BoxOfficeList: \(error.localizedDescription)")
                }
            }, receiveValue: { [weak self] viewModels in
                guard let self else { return }
                self.cellModels = viewModels
            }).store(in: &subscriptions)
        
        selectItem
            .compactMap { [weak self] index in
                guard let self else { return nil }
                let vc = MovieDetailViewController()
                vc.viewModel = MovieDetailViewModel(movie: self.cellModels[index].movie)
                return .pushViewController(vc)
            }.subscribe(viewAction)
            .store(in: &subscriptions)
    }
    
    enum ViewAction {
        case pushViewController(_ vc: UIViewController)
    }
}

enum BoxOfficeFilter {
    case daily
    case weekend
    case weekday
    case weekly
}
