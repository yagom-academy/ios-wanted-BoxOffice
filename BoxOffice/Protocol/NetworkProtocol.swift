//
//  NetworkProtocol.swift
//  BoxOffice
//
//  Created by 천승희 on 2023/01/03.
//

import Foundation

protocol NetworkProtocol {
    func getBoxOfficeData(completion: @escaping (Result<DailyBoxOffice, Error>) -> Void)
}
