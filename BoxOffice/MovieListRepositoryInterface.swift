//
//  MovieListRepositoryInterface.swift
//  BoxOffice
//
//  Created by 천수현 on 2023/01/02.
//

import Foundation

protocol MovieListRepositoryInterface {
    func fetchMovieList(page: Int, dayType: DayType, completion: @escaping (Result<[MovieOverview], Error>) -> Void)
}
