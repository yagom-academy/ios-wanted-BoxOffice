//
//  DetailViewModel.swift
//  BoxOffice
//
//  Created by Ellen J on 2023/01/05.
//

import Foundation
import Combine

protocol DetailViewModelInputInterface: AnyObject {
    func onViewDidLoad()
}

protocol DetailViewModelOutputInterface: AnyObject {
    var detailBoxOfficePublisher: PassthroughSubject<CustomBoxOffice, Never> { get }
}

protocol DetailViewModelInterface: AnyObject {
    var input: DetailViewModelInputInterface { get }
    var output: DetailViewModelOutputInterface { get }
}

final class DetailViewModel: DetailViewModelInterface, DetailViewModelOutputInterface {
    
    var input: DetailViewModelInputInterface { self }
    var output: DetailViewModelOutputInterface { self }
    
    var detailBoxOfficePublisher = PassthroughSubject<CustomBoxOffice, Never>()
    private let detailBoxOffice: CustomBoxOffice
    
    init(detailBoxOffice: CustomBoxOffice) {
        self.detailBoxOffice = detailBoxOffice
    }
}

extension DetailViewModel: DetailViewModelInputInterface {
    func onViewDidLoad() {
        output.detailBoxOfficePublisher.send(detailBoxOffice)
    }
}
