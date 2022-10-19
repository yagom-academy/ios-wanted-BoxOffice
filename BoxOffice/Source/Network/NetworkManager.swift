//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by 권준상 on 2022/10/19.
//

import Foundation

final class NetworkManager {
    static let shared = NetworkManager()
    var dailyBoxOfficeURL = URLComponents(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?")
    
    
    func getDailyMovieRank(date: String) async throws -> [SimpleMovieInfo] {
        let queryItems = [URLQueryItem(name: "key", value: UserDefaults.standard.string(forKey: UserDefaultKey.BOX_OFFICE_KEY)),
                          URLQueryItem(name: "targetDt", value: date)]
        
        dailyBoxOfficeURL?.queryItems = queryItems
        
        guard let url = dailyBoxOfficeURL?.url else { throw NetworkError.pathErr }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
            throw NetworkError.invalidErr
        }
        let successRange = 200..<300
        
        guard successRange.contains(statusCode) else {
            throw NetworkError.serverErr
        }
        
        let decoder = JSONDecoder()
        let result = try decoder.decode(DailyBoxOfficeDTO.self, from: data)
        var movieList: [SimpleMovieInfo] = []
        
        for dailyBoxOffice in result.boxOfficeResult.dailyBoxOfficeList {
            let simpleMovieInfo = SimpleMovieInfo(rank: Int(dailyBoxOffice.rank) ?? 0,
                                                  name: dailyBoxOffice.movieNm,
                                                  inset: dailyBoxOffice.rankInten,
                                                  audience: dailyBoxOffice.audiAcc,
                                                  release: dailyBoxOffice.openDt,
                                                  oldAndNew: dailyBoxOffice.rankOldAndNew)
            movieList.append(simpleMovieInfo)
        }
        
        return movieList
    }
}
