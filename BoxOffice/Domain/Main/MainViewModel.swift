//
//  MainViewModel.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/03.
//

import Foundation
import Combine

protocol MainViewModelInputInterface: AnyObject {
    func onViewDidLoad()
}

protocol MainViewModelOutputInterface: AnyObject {
    var boxOfficePublisher: PassthroughSubject<[DailyBoxOffice], Never> { get }
}

protocol MainViewModelInterface: AnyObject {
    var input: MainViewModelInputInterface { get }
    var output: MainViewModelOutputInterface { get }
}

final class MainViewModel: MainViewModelInterface, MainViewModelOutputInterface {
    
    // MARK: MainViewModelInterface
    var input: MainViewModelInputInterface { self }
    var output: MainViewModelOutputInterface { self }
    
    // MARK: MainViewModelOutputInterface
    var boxOfficePublisher = PassthroughSubject<[DailyBoxOffice], Never>()
    
    private var cancelable = Set<AnyCancellable>()
    private let networkHandler: Networkerable?
    private let itemPerPage = "10"
    private let currentDate = "20230101"

    init(networkHandler: Networkerable) {
        self.networkHandler = networkHandler
    }
}

extension MainViewModel: MainViewModelInputInterface {
    func onViewDidLoad() {
        
        networkHandler?.request(
            BoxOfficeAPI.dailyBoxOffice(key: "d9346d4d74e3d01826d92e2a0ebfaf6e",
                                        targetDate: currentDate,
                                       itemPerPage: itemPerPage,
                                       isMultiMovie: "N"),
            dataType: DailyBoxOfficeConnection.self
        )
        .sink(receiveCompletion: { error in
            print(error)
        }, receiveValue: { [weak self] model in
            guard let self = self else { return }
            self.boxOfficePublisher.send(model.boxOfficeResult.boxOfficeList)
        })
        .store(in: &cancelable)
    }
}
