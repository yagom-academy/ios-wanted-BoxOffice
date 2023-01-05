//
//  BoxOfficeListViewModel.swift
//  BoxOffice
//
//  Created by Ari on 2023/01/03.
//

import Foundation
import Combine

protocol BoxOfficeListViewModelInput {
    
    func viewDidLoad()
    func didTapSegmentControl(_ index: Int)
    
}

protocol BoxOfficeListViewModelOutput {
    
    var movies: AnyPublisher<[MovieCellViewModel], Never> { get }
    var isLoading: AnyPublisher<Bool, Never> { get }
    var cellModels: [MovieCellViewModel] { get }
}

protocol BoxOfficeListViewModel {
    
    var input: BoxOfficeListViewModelInput { get }
    var output: BoxOfficeListViewModelOutput { get }
    
    var cancellables: Set<AnyCancellable> { get }
    
}

final class DefaultBoxOfficeListViewModel: BoxOfficeListViewModel {
    
    enum ViewAction {
        case pushViewController(movie: Movie)
    }
    
    enum BoxOfficeFilter: Int {
        case daily = 0
        case weekly = 1
        case weekend = 2
    }
    
    private let repository: BoxOfficeRepository
    private(set) var cancellables: Set<AnyCancellable> = .init()
    
    init(repository: BoxOfficeRepository = DefaultBoxOfficeRepository()) {
        self.repository = repository
    }
    
    private var _movies = PassthroughSubject<[MovieCellViewModel], Never>()
    private var _isLoading = PassthroughSubject<Bool, Never>()
    private var _cellViewMovels: [MovieCellViewModel] = .init() {
        didSet {
            if _cellViewMovels.isEmpty {
                return
            }
            _movies.send(_cellViewMovels)
        }
    }
    @Published private var filter: BoxOfficeFilter = .daily
    
    private let viewAction = PassthroughSubject<ViewAction, Never>()
}

// MARK: - Input
extension DefaultBoxOfficeListViewModel: BoxOfficeListViewModelInput {
    
    var input: BoxOfficeListViewModelInput { self }
    
    func viewDidLoad() {
        bind()
    }
    
    func didTapSegmentControl(_ index: Int) {
        guard let filter = BoxOfficeFilter(rawValue: index) else {
            return
        }
        self.filter = filter
    }
    
}

// MARK: - Output
extension DefaultBoxOfficeListViewModel: BoxOfficeListViewModelOutput {
    
    var output: BoxOfficeListViewModelOutput { self }
    
    var movies: AnyPublisher<[MovieCellViewModel], Never> { _movies.eraseToAnyPublisher() }
    var isLoading: AnyPublisher<Bool, Never> { _isLoading.eraseToAnyPublisher() }
    var cellModels: [MovieCellViewModel] { return _cellViewMovels }
    
}


private extension DefaultBoxOfficeListViewModel {
    
    func bind() {
        _isLoading.send(true)
        $filter
            .removeDuplicates()
            .handleEvents(receiveOutput: { [weak self] _ in
                self?._cellViewMovels = []
            }).flatMap { [weak self] filter -> AnyPublisher<[Movie], Error> in
                guard let self else {
                    return Empty().eraseToAnyPublisher()
                }
                self._isLoading.send(true)
                switch filter {
                case .daily: return self.repository.dailyBoxOffice(date: Date.yesterday)
                case .weekly: return self.repository.weeklyBoxOffice(date: Date.lastWeek, weekGb: .weekly)
                case .weekend: return self.repository.weeklyBoxOffice(date: Date.lastWeek, weekGb: .weekend)
                }
            }.map { $0.map { movie in
                return DefaultMovieCellViewModel(movie: movie)
            }}.sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    debugPrint(error)
                }
            }, receiveValue: { [weak self] movies in
                self?._cellViewMovels = movies
                self?._isLoading.send(false)
            }).store(in: &cancellables)
    }
}
