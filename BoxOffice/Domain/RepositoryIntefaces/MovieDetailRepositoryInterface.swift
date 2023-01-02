//
//  MovieDetailRepositoryInterface.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/02.
//

import Foundation

protocol MovieDetailRepositoryInterface {
    func fetchMovieDetail(of movieCode: String, completion: @escaping (Result<MovieDetail, Error>) -> Void)
}
