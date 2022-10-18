//
//  MovieService.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/19.
//

import Foundation

enum NetworkError : Error{
    case badURL, noData, decodingError
}

class MovieService {
    private let apiKey = "f5eef3421c602c6cb7ea224104795888"
    
    var date : String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "YYYYMMdd"
        let date = Date(timeIntervalSinceNow: -86400)
        return dateFormatter.string(from: date)
    }
    
//    func getDate() -> String{
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateFormat = "YYYYMMdd"
//        let date = Date()
//        return dateFormatter.string(from: date)
//    }
    
    func getMovieInfo(completion:@escaping (Result<BoxOfficeResponse,NetworkError>) -> Void){
        let url = URL(string:"https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey)&targetDt=\(date)&wideAreaCd=0105001")
        guard let url = url else { return completion(.failure(.badURL))}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return completion(.failure(.noData))}
            let boxOfficeResponse = try? JSONDecoder().decode(BoxOfficeResponse.self, from: data)
            if let boxOfficeResponse = boxOfficeResponse{
                completion(.success(boxOfficeResponse))
            }else{
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func getEnglishMovieTitle(movieCd : String ,completion:@escaping(Result<MovieInfoResponse,NetworkError>) -> Void){
        let url = URL(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd=\(movieCd)")
        guard let url = url else { return completion(.failure(.badURL))}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else { return completion(.failure(.noData))}
            let movieInfoResponse = try? JSONDecoder().decode(MovieInfoResponse.self, from: data)
            if let movieInfoResponse = movieInfoResponse{
                completion(.success(movieInfoResponse))
            }else{
                completion(.failure(.decodingError))
            }
        }.resume()
    }
    
    func getMoviePoster(englishTitle:String,releaseYear:String,completion:@escaping(Result<MoviePoster,NetworkError>)->Void){
        let url = URL(string: "https://www.omdbapi.com/?apikey=c6af1df&t=\(englishTitle)&y=\(releaseYear)")
        guard let url = url else { return completion(.failure(.badURL))}
        URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {return completion(.failure(.noData))}
            let moviePoster = try? JSONDecoder().decode(MoviePoster.self, from: data)
            if let moviePoster = moviePoster {
                completion(.success(moviePoster))
            }else{
                completion(.failure(.decodingError))
            }
        }.resume()
    }

}


