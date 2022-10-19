//
//  BoxOfficeListCollectionViewCellModel.swift
//  BoxOffice
//
//  Created by CodeCamper on 2022/10/19.
//

import Foundation
import UIKit


class BoxOfficeListCollectionViewCellModel {
    // MARK: Input
    
    // MARK: Output
    @Published var movie: Movie
    
    // MARK: Properties
    
    // MARK: Life Cycle
    init(movie: Movie) {
        self.movie = movie
        bind()
    }
    
    
    // MARK: Binding
    func bind() {

    }
}
