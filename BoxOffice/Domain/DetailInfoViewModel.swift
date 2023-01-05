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
}

protocol DetailInfoViewModelOutputInterface: AnyObject {
    var customBoxOfficePublisher: PassthroughSubject<CustomBoxOffice, Never> { get }
    var detailBoxOfficePublisher: PassthroughSubject<DetailBoxOffice, Never> { get }
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
    
    private var cancelable = Set<AnyCancellable>()
    private let networkHandler = Networker()
    private let customBoxOffice: CustomBoxOffice
    private var detailBoxOffice: DetailBoxOffice?
    
    init(customBoxOffice: CustomBoxOffice) {
        self.customBoxOffice = customBoxOffice
        print(customBoxOffice)
    }
}

extension DetailInfoViewModel: DetailInfoViewModelInputInterface {
    func onViewDidLoad() {
        customBoxOfficePublisher.send(customBoxOffice)
        
        networkHandler.request(BoxOfficeAPI.detailBoxOffice(movieCode: customBoxOffice.boxOffice.movieCode))
            .sink { completion in
                
            } receiveValue: { [weak self] (model: DetailBoxOfficeConnection) in
                guard let self = self else { return }
                self.output.detailBoxOfficePublisher.send(model.result.movieInfo)
            }
            .store(in: &cancelable)
    }
}
