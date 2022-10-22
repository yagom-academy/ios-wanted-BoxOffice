//
//  MovieDataService.swift
//  BoxOffice
//
//  Created by KangMingyo on 2022/10/18.
//

import Foundation

enum NetworkError: Error {
    case badUrl
}

class BoxOfficeService {
    private var apiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "KeyList", ofType: "plist") else {
                fatalError("Couldn't find KeyList")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            
            guard let value = plist?.object(forKey: "Movie_API_KEY") as? String else {
                fatalError("Couldn't find key 'Movie_API_KEY")
            }
            return value
        }
    }
    
    private var posterApiKey: String {
        get {
            guard let filePath = Bundle.main.path(forResource: "KeyList", ofType: "plist") else {
                fatalError("Couldn't find KeyList")
            }
            let plist = NSDictionary(contentsOfFile: filePath)
            
            guard let value = plist?.object(forKey: "Poster_API_KEY") as? String else {
                fatalError("Couldn't find key 'Poster_API_KEY")
            }
            return value
        }
    }
    
    func getBoxOfficeData(date: String) async throws -> BoxOfficeData {
        let url = URL(string: "https://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(apiKey)&targetDt=\(date)&wideAreaCd=0105001")
        guard let url = url else { throw NetworkError.badUrl }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw NetworkError.badUrl }
        guard statusCode == 200 else {throw NetworkError.badUrl}
        let result = try JSONDecoder().decode(BoxOfficeData.self, from: data)
        return result
    }
    
    func getMovieDetailData(movieCode: String) async throws -> MovieDetailData {
        let url = URL(string: "https://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(apiKey)&movieCd=\(movieCode)")
        guard let url = url else { throw NetworkError.badUrl }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw NetworkError.badUrl }
        guard statusCode == 200 else {throw NetworkError.badUrl}
        let result = try JSONDecoder().decode(MovieDetailData.self, from: data)
        return result
    }
    
    func getMoviePosterData(movieName: String) async throws -> MoviePosterData {
        var url = String("https://api.themoviedb.org/3/search/movie?api_key=\(posterApiKey)&language=ko&page=1&include_adult=false&region=KR&query=\(movieName)")
        url = url.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!
        let posterURL = URL(string: url)
        guard let url = posterURL else { throw NetworkError.badUrl }
        let (data, response) = try await URLSession.shared.data(from: url)
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else { throw NetworkError.badUrl }
        guard statusCode == 200 else {throw NetworkError.badUrl}
        let result = try JSONDecoder().decode(MoviePosterData.self, from: data)
        return result
    }
}
