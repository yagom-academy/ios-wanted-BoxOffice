//
//  MovieListRepository.swift
//  BoxOffice
//
//  Created by minsson on 2023/01/03.
//

import Foundation

final class MovieListRepository: MovieListRepositoryInterface {
    private let networkService = NetworkService.shared
    
    func fetchMovieList(page: Int, dayType: DayType, completion: @escaping (Result<[MovieOverview], Error>) -> Void) {
        
        var urlComponents = URLComponents(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice")
        
        switch dayType {
        case .weekdays:
            urlComponents?.path = "/searchDailyBoxOfficeList"
        case .weekends:
            urlComponents?.path = "/searchWeeklyBoxOfficeList"
        default:
            break
        }
        
        // TODO: value 채우기
        urlComponents?.queryItems = [
            .init(name: "key", value: ""),
            .init(name: "targetDt", value: "")
        ]
        
        guard let url = urlComponents?.url else {
            return
        }
        
        let urlRequest = URLRequest(url: url)
    
        let dataTask = networkService.dataTask(request: urlRequest) { result in
            switch result {
            case .success(let data):
                do {
                    let movieOverviewWeeklyDTO = try JSONDecoder().decode(MovieOverviewWeeklyDTO.self, from: data)
                    let movieOverviews: [MovieOverview] = movieOverviewWeeklyDTO.toDomain()
                    completion(.success(movieOverviews))
                } catch {
                    completion(.failure(error))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
        dataTask.resume()
    }
}
