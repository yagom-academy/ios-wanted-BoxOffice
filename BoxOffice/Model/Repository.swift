//
//  Repository.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

final class Repository {
    
    private let firstApiKey = "325ca562"
    private let secondApiKey = ""
    
    private let apiUrl = "http://www.omdbapi.com/?i=tt3896198"
    private let posterUrl = "http://img.omdbapi.com/?"
    
    typealias FetchResult = Result<Data, Error>
    
    func fetch(completion: @escaping (FetchResult) -> Void) {
        let urlString = apiUrl + firstApiKey
        guard let url = URL(string: urlString) else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard error == nil else {
                completion(.failure(error!))
                return
            }
            guard let response = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "네트워킹 실패", code: -1)))
                return
            }
            print("\(#function), \(response.statusCode)")
            
            guard let data = data else { return }
            completion(.success(data))
        }.resume()
    }
}
