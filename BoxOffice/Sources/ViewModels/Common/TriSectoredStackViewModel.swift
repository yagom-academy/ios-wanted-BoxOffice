//
//  TriSectoredStackViewModel.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/21.
//

import Foundation
import UIKit
import Combine

class TriSectoredStackViewModel {
    // MARK: Input
    
    // MARK: Output
    @Published var list: [String]
    @Published var labelViewModels = [CenterLabelViewModel]()
    
    // MARK: Properties
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init(list: [String]) {
        self.list = list
        bind()
    }
    
    func bind() {
        $list
            .sink(receiveValue: { [weak self] list in
                guard let self else { return }
                self.labelViewModels = list.map { CenterLabelViewModel(title: $0) }
            }).store(in: &subscriptions)
    }
}
