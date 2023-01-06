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
    private var dailyBoxOffice: [DailyBoxOffice] = []
    private var englishMovieName: [String] = []
    private var customBoxOffice: [CustomBoxOffice] = []
    private var titlesDictionary: [String: String] = [:]
    private var posterDictionary: [String: String] = [:]
    
    init(networkHandler: Networkerable) {
        self.networkHandler = networkHandler
    }
    
    private func requestBoxOffice() {
        guard let networkHandler = networkHandler else { return }
        let dateFormmatter = DateFormatter()
        dateFormmatter.dateFormat = "YYYYMMDD"
        guard let date = Calendar.current.date(byAdding: .day, value: -1, to: Date()) else { return }
        let yesterDay = dateFormmatter.string(from: date)
        
        networkHandler.request(BoxOfficeAPI.dailyBoxOffice(
            targetDate: yesterDay,
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
                self.titlesDictionary.updateValue(
                    model.result.movieInfo.movieEnglishName,
                    forKey: model.result.movieInfo.movieName
                )
            }
            .store(in: &cancelable)
    }
    
    private func requestPosterURL() {
        guard let networkHandler = networkHandler else { return }
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
                    self.configureCustomBoxOffice()
                    self.output.boxOfficePublisher.send(self.customBoxOffice)
                case .failure(let error):
                    print("requestPosterURL Error: \(error)")
                }
            } receiveValue: { [weak self] (poster: MoviePoster) in
                guard let self = self else { return }
                self.posterDictionary.updateValue(
                    poster.poster ?? "https://i.imgur.com/PQQuSIL.png",
                    forKey: poster.title ?? ""
                )
            }
            .store(in: &cancelable)
    }

    private func configureCustomBoxOffice() {
        dailyBoxOffice.enumerated().forEach { sequence, element in
            guard let englishName = titlesDictionary[element.title] else { return }
            let poster = posterDictionary[englishName]
            
            customBoxOffice.append(
                .init(boxOffice: dailyBoxOffice[sequence],
                      posterURL: poster ?? "https://i.imgur.com/PQQuSIL.png")
            )
        }

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
