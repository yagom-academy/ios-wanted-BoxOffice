//
//  BoxOfficeListViewModel.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/19.
//

import Foundation
import UIKit


class BoxOfficeListViewModel {
    // MARK: Input
    
    // MARK: Output
    @Published var movies = [Movie]()
    
    // MARK: Properties
    
    // MARK: Life Cycle
    init() {
        bind()
    }
    
    
    // MARK: Binding
    func bind() {

    }
}
