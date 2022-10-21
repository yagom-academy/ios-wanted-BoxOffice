//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/19.
//

import UIKit

final class NetworkManager {
    static let shared = NetworkManager()
    var dailyBoxOfficeURL = URLComponents(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?")
    var detailMovieInfoURL = URLComponents(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?")
    var posterURL = URLComponents(string: "http://www.omdbapi.com/?")
    var weekendBoxOfficeURL = URLComponents(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?")
        
    func getDailyMovieRank(date: String) async throws -> [SimpleMovieInfoEntity] {
        let queryItems = [URLQueryItem(name: "key", value: UserDefaults.standard.string(forKey: UserDefaultKey.BOX_OFFICE_KEY)),
                          URLQueryItem(name: "targetDt", value: date),
                          URLQueryItem(name: "wideAreaCd", value: "0105001")]
        
        dailyBoxOfficeURL?.queryItems = queryItems
        
        guard let dailyURL = dailyBoxOfficeURL?.url else { throw NetworkError.pathErr }
        
        let (data, response) = try await URLSession.shared.data(from: dailyURL)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.invalidErr
        }
        let successRange = 200..<300
        
        guard successRange.contains(statusCode) else {
            throw NetworkError.serverErr
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(DailyBoxOfficeDTO.self, from: data)
        var movieList:[SimpleMovieInfoEntity] = []
        
        for dailyBoxOffice in result.boxOfficeResult.dailyBoxOfficeList {
            let englishName = try await self.getEnglishName(movieCd: dailyBoxOffice.movieCD)
            
            let simpleMovieInfo = SimpleMovieInfoEntity(movieId: dailyBoxOffice.movieCD,
                                                  englishName: englishName,
                                                  rank: Int(dailyBoxOffice.rank) ?? 0,
                                                  name: dailyBoxOffice.movieNm,
                                                  inset: dailyBoxOffice.rankInten,
                                                  audience: dailyBoxOffice.audiAcc,
                                                  release: dailyBoxOffice.openDt,
                                                  oldAndNew: dailyBoxOffice.rankOldAndNew)
            movieList.append(simpleMovieInfo)
        }
        return movieList
    }
    
    func getEnglishName(movieCd: String) async throws -> String {
        let queryItems = [URLQueryItem(name: "key", value: UserDefaults.standard.string(forKey: UserDefaultKey.BOX_OFFICE_KEY)),
                          URLQueryItem(name: "movieCd", value: movieCd)]
        detailMovieInfoURL?.queryItems = queryItems
        
        guard let detailURL = detailMovieInfoURL?.url else { throw NetworkError.pathErr }
        
        let (data, response) = try await URLSession.shared.data(from: detailURL)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.invalidErr
        }
        let successRange = 200..<300
        
        guard successRange.contains(statusCode) else {
            throw NetworkError.serverErr
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(MovieInfoDTO.self, from: data)
        
        return result.movieInfoResult.movieInfo.movieNmEn
    }
    
    func getPosterImage(englishName: String) async throws -> UIImage {
        let cachedKey = NSString(string: englishName)

        if let cachedImage = ImageCacheManager.shared.object(forKey: cachedKey) {
            return cachedImage
        }
        
        let queryItems = [URLQueryItem(name: "t", value: englishName),
                          URLQueryItem(name: "apikey", value: UserDefaults.standard.string(forKey: UserDefaultKey.POSTER_KEY))]
        posterURL?.queryItems = queryItems
        
        guard let posterURL = posterURL?.url else { throw NetworkError.pathErr }
        
        let (data, response) = try await URLSession.shared.data(from: posterURL)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.invalidErr
        }
        let successRange = 200..<300
        
        guard successRange.contains(statusCode) else {
            throw NetworkError.serverErr
        }
        
        let decoder = JSONDecoder()
        guard let result = try? decoder.decode(MoviePosterInfoDTO.self, from: data) else {
            return UIImage(systemName: "video.fill")!
        }
        
        let url = URL(string: result.poster)
        if let imageData = try? Data(contentsOf: url!) {
            let image = UIImage(data: imageData)
            ImageCacheManager.shared.setObject(image!, forKey: cachedKey)
            return image!
        } else {
            return UIImage(systemName: "video.fill")!
        }
    }
    
    func getDetailMovieInfo(movieCd: String) async throws -> DetailMovieInfoEntity {
        let queryItems = [URLQueryItem(name: "key", value: UserDefaults.standard.string(forKey: UserDefaultKey.BOX_OFFICE_KEY)),
                          URLQueryItem(name: "movieCd", value: movieCd)]
        detailMovieInfoURL?.queryItems = queryItems
        
        guard let detailURL = detailMovieInfoURL?.url else { throw NetworkError.pathErr }
        
        let (data, response) = try await URLSession.shared.data(from: detailURL)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.invalidErr
        }
        let successRange = 200..<300
        
        guard successRange.contains(statusCode) else {
            throw NetworkError.serverErr
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(MovieInfoDTO.self, from: data)
        
        var genreNames: [String] = []
        var actorNames: [String] = []
        
        for genre in result.movieInfoResult.movieInfo.genres {
            genreNames.append(genre.genreNm)
        }
        for actor in result.movieInfoResult.movieInfo.actors {
            actorNames.append(actor.peopleNm)
        }
        let detailMovieInfo = DetailMovieInfoEntity(productYear: result.movieInfoResult.movieInfo.prdtYear,
                                                    showTime: result.movieInfoResult.movieInfo.showTm,
                                                    openYear: result.movieInfoResult.movieInfo.openDt,
                                                    genreName: genreNames,
                                                    directors: result.movieInfoResult.movieInfo.directors.first?.peopleNm ?? "",
                                                    actors: actorNames,
                                                    watchGrade: result.movieInfoResult.movieInfo.audits.first?.watchGradeNm ?? "전체 이용가")
        
        return detailMovieInfo
    }
    
    func getWeekendMovieRank(date: String) async throws -> [SimpleMovieInfoEntity] {
        let queryItems = [URLQueryItem(name: "key", value: UserDefaults.standard.string(forKey: UserDefaultKey.BOX_OFFICE_KEY)),
                          URLQueryItem(name: "targetDt", value: date),
                          URLQueryItem(name: "wideAreaCd", value: "0105001")]
        
        weekendBoxOfficeURL?.queryItems = queryItems
        
        guard let weekendURL = weekendBoxOfficeURL?.url else { throw NetworkError.pathErr }
        
        let (data, response) = try await URLSession.shared.data(from: weekendURL)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.invalidErr
        }
        let successRange = 200..<300
        
        guard successRange.contains(statusCode) else {
            throw NetworkError.serverErr
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(WeekendBoxOfficeDTO.self, from: data)
        var movieList:[SimpleMovieInfoEntity] = []
        
        for weeklyBoxOffice in result.boxOfficeResult.weeklyBoxOfficeList {
            let englishName = try await self.getEnglishName(movieCd: weeklyBoxOffice.movieCD)
            
            let simpleMovieInfo = SimpleMovieInfoEntity(movieId: weeklyBoxOffice.movieCD,
                                                  englishName: englishName,
                                                  rank: Int(weeklyBoxOffice.rank) ?? 0,
                                                  name: weeklyBoxOffice.movieNm,
                                                  inset: weeklyBoxOffice.rankInten,
                                                  audience: weeklyBoxOffice.audiAcc,
                                                  release: weeklyBoxOffice.openDt,
                                                  oldAndNew: weeklyBoxOffice.rankOldAndNew)
            movieList.append(simpleMovieInfo)
        }
        return movieList
    }
}
