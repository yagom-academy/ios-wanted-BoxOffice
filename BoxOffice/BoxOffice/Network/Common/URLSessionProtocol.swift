//
//  URLSessionProtocol.swift
//  BoxOffice
//
//  Created by bard on 2023/01/02.
//

import Foundation

protocol SessionProtocol {
    func dataTask<T: APIRequest>(
        with request: T,
        completionHandler: @escaping (Result<Data, Error>) -> Void
    ) 
}
