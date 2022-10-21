//
//  APIManager.swift
//  BoxOffice
//
//  Created by sole on 2022/10/21.
//

import Foundation

enum APIManager {
    static func fetchMainItems(date: Date) async throws -> [MainItem] {
        var mainItems = [MainItem]()
        let data = try await fetchData(url: URLManager.createKobisBoxOfficeURL(targetDate: Date().yesterday))
        let boxOfficelist: [KobisDailyBoxOfficeList] = try ParseManager.parse(data)
        let moviCodeList = boxOfficelist.map { $0.movieCode }
        
        try await withThrowingTaskGroup(of: (KobisMovieInfo, TmdbAsset?).self, body: { group in
            for movieCode in moviCodeList {
                group.addTask {
                    let movieInfoData = try await self.fetchData(url: URLManager.createKobisMovieInfoURL(movieCode: movieCode))
                    let movieInfo: KobisMovieInfo = try ParseManager.parse(movieInfoData)
                    let tmdbAssetData = try? await self.fetchData(url: URLManager.createTmdbURL(movieNameInEnglish: movieInfo.nameInEnglish))
                    let movieAsset: TmdbAsset? = try? ParseManager.parse(tmdbAssetData)
                    return (movieInfo, movieAsset)
                }
            }
            
            for try await (movieInfo, movieAsset) in group {
                if let findMovie = boxOfficelist.filter({ $0.movieCode == movieInfo.movieCode }).first {
                    let movie = try MovieDataManager.convertToMovieType(main: findMovie, detail: movieInfo, asset: movieAsset)
                    let mainItem: MainItem = .ranking(movie)
                    mainItems.append(mainItem)
                }
            }
        })
        return mainItems
    }
    
    private static func fetchData(url: URL) async throws -> Data {
        let(data, response) = try await URLSession.shared.data(from: url)
        let optionalStatusCode = (response as? HTTPURLResponse)?.statusCode
        guard let statusCode = optionalStatusCode,
            (200...299).contains(statusCode) else {
            throw APIError.response
        }
        return data
    }
}
