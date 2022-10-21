//
//  MoviesListViewModel.swift
//  BoxOffice
//
//  Created by channy on 2022/10/19.
//

import Foundation

class MoviesListViewModel {
    
    // Output
    var items: Observable<[MoviesListItemViewModel]>
    
    init(items: Observable<[MoviesListItemViewModel]>) {
        self.items = items
    }
    
}
