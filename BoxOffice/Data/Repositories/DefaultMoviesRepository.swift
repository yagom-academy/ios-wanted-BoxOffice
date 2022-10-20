//
//  DefaultMoviesRepository.swift
//  BoxOffice
//
//  Created by channy on 2022/10/19.
//

import Foundation

enum RepositoryError: Error {
    case decodeError
    case networkError
    
    var localizedDescription: String {
        switch self {
        case .decodeError: return "Decode Error"
        case .networkError: return "Network Error"
        }
    }
}

final class DefaultMoviesRepository {

    private let network = NetworkService()
    private let koficKey = "dfbe07a1bbd1113912d5c6760b0fe5ce"
    private let decoder = JSONDecoder()
    
    init() { }
    
}

extension DefaultMoviesRepository: MoviesRepository {
    func fetchMoviesList(completion: @escaping (Result<[Movie], RepositoryError>) -> Void) {
        let calender = Calendar.current
        let date = formatter.string(from: calender.date(byAdding: .day, value: -1, to: Date()) ?? Date())
        
        let url = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(koficKey)&targetDt=\(date)&wideAreaCd=0105001"
        
        print(url)
        
        network.request(request: .get, url: url, body: nil) { result in
            switch result {
            case .success(let data):
                guard let responseList = try? JSONDecoder().decode(MoviesResponseKoficList.self, from: data) else {
                    completion(.failure(.decodeError))
                    return
                }
                
                var movieList: [Movie] = []
                responseList.boxOfficeResult.dailyBoxOfficeList.forEach { movieList.append($0.toDomain()) }
                
                completion(.success(movieList))
                
            case .failure(_):
                completion(.failure(.networkError))
            }
        }
    }
}

private let formatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateFormat = "yyyyMMdd"
    
    return formatter
}()
