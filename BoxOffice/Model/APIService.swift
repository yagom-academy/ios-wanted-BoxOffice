//
//  APIService.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

final class APIService {
    
    let repository = Repository()
    
    typealias ParseResult = Result<BoxOfficeEntity?, Error>
    
    func fetch(completion: @escaping (ParseResult) -> Void) {
        repository.fetch { [weak self] result in
            switch result {
            case let .success(data):
                let movieList = self?.parseJson(data: data)
                completion(.success(movieList))
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
    
    private func parseJson(data: Data) -> BoxOfficeEntity? {
        do {
            let decodeData = try JSONDecoder().decode(BoxOfficeEntity.self, from: data)
            return decodeData
        } catch {
            print("디코딩 실패")
            print(error.localizedDescription)
            return nil
        }
    }
}
