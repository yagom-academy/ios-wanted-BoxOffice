//
//  DetailInfoViewModel.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/05.
//

import Foundation
import Combine

protocol DetailInfoViewModelInputInterface: AnyObject {
    func onViewDidLoad()
    func touchUpShareButton()
}

protocol DetailInfoViewModelOutputInterface: AnyObject {
    var customBoxOfficePublisher: PassthroughSubject<CustomBoxOffice, Never> { get }
    var detailBoxOfficePublisher: PassthroughSubject<DetailBoxOffice, Never> { get }
    var shareMovieInfoPublisher: PassthroughSubject<[String], Never> { get }
}

protocol DetailInfoViewModelInterface: AnyObject {
    var input: DetailInfoViewModelInputInterface { get }
    var output: DetailInfoViewModelOutputInterface { get }
}

final class DetailInfoViewModel: DetailInfoViewModelInterface, DetailInfoViewModelOutputInterface {
    
    // MARK: DetailInfoViewModel
    var input: DetailInfoViewModelInputInterface { self }
    var output: DetailInfoViewModelOutputInterface { self }
    
    // MARK: DetailInfoViewModelOutputInterface
    var customBoxOfficePublisher = PassthroughSubject<CustomBoxOffice, Never>()
    var detailBoxOfficePublisher = PassthroughSubject<DetailBoxOffice, Never>()
    var shareMovieInfoPublisher = PassthroughSubject<[String], Never>()
    
    private var cancelable = Set<AnyCancellable>()
    private let networkHandler = Networker()
    private let customBoxOffice: CustomBoxOffice
    private var detailBoxOffice: DetailBoxOffice?
    
    init(customBoxOffice: CustomBoxOffice) {
        self.customBoxOffice = customBoxOffice
    }
}

extension DetailInfoViewModel: DetailInfoViewModelInputInterface {
    func onViewDidLoad() {
        customBoxOfficePublisher.send(customBoxOffice)
        
        networkHandler.request(BoxOfficeAPI.detailBoxOffice(movieCode: customBoxOffice.boxOffice.movieCode))
            .sink { completion in
                
            } receiveValue: { [weak self] (model: DetailBoxOfficeConnection) in
                guard let self = self else { return }
                self.detailBoxOffice = model.result.movieInfo
                self.output.detailBoxOfficePublisher.send(model.result.movieInfo)
            }
            .store(in: &cancelable)
    }
    
    func touchUpShareButton() {
        guard let detailBoxOffice = detailBoxOffice else { return }
        let directorName: String = detailBoxOffice.directors[0].peopleName ?? ""
        let peopleName: String = detailBoxOffice.actors[0].peopleName ?? ""
        shareMovieInfoPublisher.send([
"""
🎥 BOX OFFICE 🎬

박스오피스 순위: \(String(describing: customBoxOffice.boxOffice.rank))
영화명: \(String(describing:detailBoxOffice.movieName))
개봉일: \(String(describing:detailBoxOffice.openDate))
관객수: \(String(describing:customBoxOffice.boxOffice.audienceCount))명
순위증감분: \(String(describing:customBoxOffice.boxOffice.rankInTen))
랭킹 신규 진입: \(String(describing:customBoxOffice.boxOffice.isNewRank))
제작연도: \(String(describing:detailBoxOffice.productionYear))
상영시간: \(String(describing:detailBoxOffice.showTime))
장르: \(String(describing:detailBoxOffice.genre[0].genreName))
감독명: \(directorName)
배우명: \(peopleName)
관람등급: \(String(describing:detailBoxOffice.audits[0].watchGrade))
"""
        ])
    }
}
