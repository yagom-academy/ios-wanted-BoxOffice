//
//  NetworkProtocol.swift
//  BoxOffice
//
//  Created by 천승희 on 2023/01/03.
//

import Foundation

protocol NetworkProtocol {
    func getFilmDetailData(completion: @escaping (Result<FilmDetails, Error>) -> Void)
    func getBoxOfficeData(completion: @escaping (Result<DailyBoxOffice, Error>) -> Void)
    func getPosterData(completion: @escaping (Result<FilmPoster, Error>) -> Void)
}
