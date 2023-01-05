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
    @Published var url = [UIImage]()

    let boxOfficeDirector = MovieRequestDirector()
    let posterImageDirector = OMDbRequestDirector()
    let networkManager = NetworkManager()
    
    init() {
        fetchDailyBoxOfficeList(dateType: .daily, targetDate: getYesterdayDate())
    }
    
    func getYesterdayDate() -> String {
        let calendar = Calendar.current
        let dateFormatter = DateFormatter()

        let date = dateFormatter.date(from: Date().translateToString())
        let beforeDay = calendar.date(byAdding: .day, value: -1, to: date ?? Date())

        return beforeDay?.translateToString() ?? ""
    }
    
    func fetchDailyBoxOfficeList(dateType: GetDateType, targetDate: String) {
        let queryItems: [String: String] = [
            "targetDt": targetDate,
            "itemPerPage": BoxOfficeListViewModelConstants.itemsPerPage.rawValue,
            "wideAreaCd": "0105001"
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
                DispatchQueue.main.async { [weak self] in
                    self?.movieList = decodedDailyBoxOffice.boxOfficeResult.dailyBoxOfficeList
                }
                
                DispatchQueue.main.sync {
                    self?.url = Array<UIImage>(repeating: UIImage(named: "NoImageNotFound")!, count: Int(BoxOfficeListViewModelConstants.itemsPerPage.rawValue) ?? 0)
                }
                
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
                                DispatchQueue.global().async { [weak self] in
                                    let data = try? Data(contentsOf: URL(string: success)!)
                                    DispatchQueue.main.async {
                                        self?.url[index] = UIImage(data: data ?? Data()) ?? UIImage()
                                    }
                                }
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
                    completion(.failure(PosterImageError.posterNotFound))
                    return
                }
                if decodedImageData.totalResults == "1" {
                    completion(.success(posterURL))
                } else {
                    completion(.failure(PosterImageError.multiplePhotos))
                }
            case .failure(let failure):
                debugPrint("BoxOfficeListViewModel - fetchMoviePoster : NetworkError - \(failure.localizedDescription)")
            }
        }
    }
}

