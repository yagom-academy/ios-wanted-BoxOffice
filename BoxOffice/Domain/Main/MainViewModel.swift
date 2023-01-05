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
    func didSelectRowAt(_ row: Int)
}

protocol MainViewModelOutputInterface: AnyObject {
    var boxOfficePublisher: PassthroughSubject<[CustomBoxOffice], Never> { get }
    var detailBoxOfficePublisher: PassthroughSubject<CustomBoxOffice, Never> { get }
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
    var boxOfficePublisher = PassthroughSubject<[CustomBoxOffice], Never>()
    var detailBoxOfficePublisher = PassthroughSubject<CustomBoxOffice, Never>()
    
    private var cancelable = Set<AnyCancellable>()
    private let networkHandler: Networkerable?
    private let itemPerPage = "10"
    private let currentDate = "20230101"
    private var dailyBoxOffice: [DailyBoxOffice] = []
    private var englishMovieName: [String] = []
    private var customBoxOffice: [CustomBoxOffice] = []
    
    init(networkHandler: Networkerable) {
        self.networkHandler = networkHandler
    }
    
    private func requestBoxOffice() {
        guard let networkHandler = networkHandler else { return }
        
        networkHandler.request(BoxOfficeAPI.dailyBoxOffice(
            targetDate: currentDate,
            itemPerPage: itemPerPage,
            isMultiMovie: "N")
        )
        .sink { [weak self] completion in
            guard let self = self else { return }
            switch completion {
            case .finished:
                print("requestBoxOffice Complete")
                self.requestEnglishMovieName()
            case .failure(let error):
                print(error)
            }
        } receiveValue: { [weak self] (model: DailyBoxOfficeConnection) in
            guard let self = self else { return }
            self.dailyBoxOffice = model.boxOfficeResult.boxOfficeList
        }
        .store(in: &cancelable)
    }
    
    private func requestEnglishMovieName() {
        guard let networkHandler = networkHandler else { return }
        Publishers.Sequence(sequence: self.dailyBoxOffice)
            .flatMap { model -> AnyPublisher<DetailBoxOfficeConnection, Error> in
                return networkHandler.request(
                    BoxOfficeAPI.detailBoxOffice(movieCode: model.movieCode)
                )
            }
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    self.requestPosterURL()
                    print("requestEnglishMovieName Complete")
                case .failure(let error):
                    print("requestEnglishMovieName Error: \(error)")
                }
            } receiveValue: { [weak self] (model: DetailBoxOfficeConnection) in
                guard let self = self else { return }
                self.englishMovieName.append(model.result.movieInfo.movieEnglishName)
            }
            .store(in: &cancelable)
    }
    
    private func requestPosterURL() {
        guard let networkHandler = networkHandler else { return }
        var indexpath = 0
        Publishers.Sequence(sequence: self.englishMovieName)
            .flatMap { movieName in
                return networkHandler.request(
                    BoxOfficeAPI.posterURL(movietitle: movieName)
                )
            }
            .sink { [weak self] completion in
                guard let self = self else { return }
                switch completion {
                case .finished:
                    print("requestPosterURL Complete")
                    self.output.boxOfficePublisher.send(self.customBoxOffice)
                case .failure(let error):
                    print("requestPosterURL Error: \(error)")
                }
            } receiveValue: { [weak self] (poster: MoviePoster)  in
                guard let self = self else { return }
                self.customBoxOffice.append(.init(boxOffice: self.dailyBoxOffice[indexpath], posterURL: poster.poster ?? ""))
                indexpath += 1
            }
            .store(in: &cancelable)
    }
}

extension MainViewModel: MainViewModelInputInterface {
    func onViewDidLoad() {
        requestBoxOffice()
    }
    
    func didSelectRowAt(_ row: Int) {
        self.output.detailBoxOfficePublisher.send(customBoxOffice[row])
    }
}
