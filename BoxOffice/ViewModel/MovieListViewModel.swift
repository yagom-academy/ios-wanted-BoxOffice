//
//  MovieListViewModel.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

final class MovieListViewModel {
    private let apiService = APIService()
    
    func fetchBoxOffice(completion: @escaping ((BoxOfficeEntity) -> Void)) {
        self.apiService.fetchBoxOffice(date: "20190601") { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func fetchPoster(completion: @escaping ((MovieEntity)) -> Void) {
        self.apiService.fetchPoster(title: "parasite") { result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
