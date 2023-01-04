//
//  BoxOfficeMainViewModel.swift
//  BoxOffice
//
//  Created by 유한석 on 2023/01/03.
//

import Foundation
import SwiftUI

enum GetDateType {
    case daily
}

enum BoxOfficeListViewModelConstants: String {
    case itemsPerPage = "10"
}

enum PosterImageError: Error {
    case multiplePhotos
    case posterNotFound
}

protocol BoxOfficeListProtocol {
    var movieList: [DailyBoxOfficeList] { get }
    
    func fetchDailyBoxOfficeList(dateType: GetDateType, targetDate: String)
}

final class BoxOfficeMainViewModel: ObservableObject, BoxOfficeListProtocol {
    
    @Published var movieList = [DailyBoxOfficeList]()
    
    let boxOfficeDirector = MovieRequestDirector()
    let posterImageDirector = OMDbRequestDirector()
    let networkManager = NetworkManager()
    
    var url: [String] = []
    
    func getYesterdayDate() -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()

        let date = dateFormatter.date(from: Date().translateToString())
        let beforeDay = calendar.date(byAdding: .day, value: -1, to: date ?? Date())

        return beforeDay?.translateToString() ?? ""
    }
    
    func fetchDailyBoxOfficeList(dateType: GetDateType, targetDate: String) { //  완료시에 뭐 할거면 컴플리션 달아도됨
        let queryItems: [String: String] = [
            "targetDt": targetDate,
            "itemPerPage": BoxOfficeListViewModelConstants.itemsPerPage.rawValue
        ]
        
        guard let dailyBoxOfficeRequest = boxOfficeDirector.createGetRequest(
            queryItems: queryItems,
            type: MovieRequestPath.dailyBoxOffice
        ) else {
            return
        }
        
        self.networkManager.executeDataTask(request: dailyBoxOfficeRequest) { [weak self] (result: Result<Data, NetWorkError>) in
            switch result {
            case .success(let data):
                guard let decodedDailyBoxOffice = JSONDecoder().decode(from: data, to: DailyMovieRank.self) else {
                    return
                }
                self?.movieList = decodedDailyBoxOffice.boxOfficeResult.dailyBoxOfficeList
                
                guard let movieListCount = self?.movieList.count else {
                    return
                }
                self?.url = Array<String>(repeating: "", count: movieListCount) // 맞는 인덱스에 넣어주기 위해 길이 미리 초기화
                
                self?.movieList.forEach { dailyBoxOfficeMovie in
                    self?.fetchMovieDetail(movieCD: dailyBoxOfficeMovie.movieCD)
                }
                
            case .failure(let failure):
                debugPrint("BoxOfficeListViewModel - FetchDailyBOxOfficeList - Networking error \(failure)")
            }
        }
    }
    
    private func fetchMovieDetail(movieCD: String) {
        let queryItems: [String: String] = [
            "movieCd": movieCD
        ]
        
        guard let movieDetailRequest = boxOfficeDirector.createGetRequest(
            queryItems: queryItems,
            type: MovieRequestPath.movieDetail
        ) else {
            return
        }
        
        self.networkManager.executeDataTask(request: movieDetailRequest) { (result: Result<Data, NetWorkError>) in
            switch result {
            case .success(let data):
                guard let decodedDailyBoxOffice = JSONDecoder().decode(from: data, to: MovieDetail.self) else {
                    return
                }
                let movieEnglishName = decodedDailyBoxOffice.movieInfoResult.movieInfo.movieNmEn
                
                self.fetchMoviePoster(movieEnglishName: movieEnglishName) { (result: Result<String, PosterImageError>) in
                    switch result {
                    case .success(let success):
                        for (index, dailyBoxOffice) in self.movieList.enumerated() {
                            if dailyBoxOffice.movieCD == movieCD {
                                self.url[index] = success
                            }
                        }
                    case .failure(let failure):
                        debugPrint("BoxOfficeListViewModel - fetchMovieModel: PosterImageCountError \(failure.localizedDescription)")
                    }
                }
            case .failure(let failure):
                debugPrint("BoxOfficeListViewModel - FetchDailyBoxOfficeList - NetworkError \(failure)")
            }
        }
    }
    
    private func fetchMoviePoster(movieEnglishName: String, completion: @escaping (Result<String, PosterImageError>) -> Void) {
        let movieImageRequestQueryItems = [
            "s": movieEnglishName
        ]
        
        guard let moviePosterRequest = posterImageDirector.createGetRequest(
            queryItems: movieImageRequestQueryItems,
            type: OMDbRequestPath.omdbPath
        ) else {
            return
        }
        
        self.networkManager.executeDataTask(request: moviePosterRequest) { (result: Result<Data, NetWorkError>) in
            switch result {
            case .success(let success):
                guard let decodedImageData = JSONDecoder().decode(from: success, to: MoviePosterImage.self),
                      let posterURL = decodedImageData.search.first?.poster
                else {
                    guard JSONDecoder().decode(from: success, to: MoviePosterNotFound.self) != nil else {
                        debugPrint("BoxOfficeListViewModel - fetchMoviePoster : PosterImageDecodingError")
                        return
                    }
                    completion(.failure(PosterImageError.posterNotFound)) // 해당 영문명 포스터가 없을 경우
                    return
                }
                if decodedImageData.totalResults == "1" {
                    completion(.success(posterURL)) // 영문명 포스터가 한장일 경우
                } else {
                    completion(.failure(PosterImageError.multiplePhotos)) // 해당 영문명 포스터가 여러장일 경우
                }
            case .failure(let failure):
                debugPrint("BoxOfficeListViewModel - fetchMoviePoster : NetworkError - \(failure.localizedDescription)")
            }
        }
    }
}

