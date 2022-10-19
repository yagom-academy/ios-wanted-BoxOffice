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
    
    func getDailyMovieRank(date: String) async throws -> [SimpleMovieInfo] {
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
        let movieList = MovieList()
        
        for dailyBoxOffice in result.boxOfficeResult.dailyBoxOfficeList {
            let englishName = try await self.getEnglishName(movieCd: dailyBoxOffice.movieCD)
            
            let simpleMovieInfo = SimpleMovieInfo(englishName: englishName,
                                                  rank: Int(dailyBoxOffice.rank) ?? 0,
                                                  name: dailyBoxOffice.movieNm,
                                                  inset: dailyBoxOffice.rankInten,
                                                  audience: dailyBoxOffice.audiAcc,
                                                  release: dailyBoxOffice.openDt,
                                                  oldAndNew: dailyBoxOffice.rankOldAndNew)
            await movieList.append(simpleMovieInfo)
        }
        return await movieList.innerList
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
}

actor MovieList {
    var innerList: [SimpleMovieInfo] = []
    func append(_ movie: SimpleMovieInfo) {
        innerList.append(movie)
    }
}
