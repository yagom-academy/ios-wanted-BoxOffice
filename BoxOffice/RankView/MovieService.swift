//
//  MovieService.swift
//  BoxOffice
//
//  Created by 엄철찬 on 2022/10/19.
//

import UIKit

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

    func getMovieInfo() async throws -> BoxOfficeResponse{
        let urlTemp = URL(string:"https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey)&targetDt=\(date)&wideAreaCd=0105001")
        guard let url = urlTemp else { throw NetworkError.badURL }
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw NetworkError.badURL }
        let successRange = 200..<300
        guard successRange ~= statusCode else {throw NetworkError.badURL}
        let result = try JSONDecoder().decode(BoxOfficeResponse.self, from: data)
        return result
    }

    func getDetailMovieInfo(movieCd:String) async throws -> MovieInfoResponse{
        let urlTemp = URL(string:"https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd=\(movieCd)")
        guard let url = urlTemp else { throw NetworkError.badURL}
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw NetworkError.badURL}
        let successRange = 200..<300
        guard successRange ~= statusCode else { throw NetworkError.badURL}
        let result = try JSONDecoder().decode(MovieInfoResponse.self, from: data)
        return result
    }
    
    func getMoviePoster(englishTitle:String,releaseYear:String) async throws -> (UIImage?,[Rating]) {
        let urlTemp = URL(string: "https://www.omdbapi.com/?apikey=c6af1df&t=\(englishTitle.makeItFitToURL())&y=\(releaseYear)")
        guard let url = urlTemp else { throw NetworkError.badURL}
        let (data,response) = try await URLSession.shared.data(from: url)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw NetworkError.badURL}
        let successRange = 200..<300
        guard successRange ~= statusCode else { throw NetworkError.badURL}
        let imageURL = try JSONDecoder().decode(MovieInfoUsingOMDB.self, from: data)
        let ratings = imageURL.Ratings
        guard let imgURL = URL(string: imageURL.Poster) else { throw NetworkError.badURL}
        let imageData = try Data(contentsOf: imgURL)
        let poster = UIImage(data: imageData)
        return (poster,ratings)
    }

}


//Metacritic
//value : "68/100"
