//
//  CenterLabelViewModel.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/21.
//

import Foundation
import UIKit
import Combine

class CenterLabelViewModel {
    // MARK: Input
    
    // MARK: Output
    @Published var title: String
    
    // MARK: Properties
    var subscriptions = [AnyCancellable]()
    
    // MARK: Life Cycle
    init(title: String) {
        self.title = title
    }
}
