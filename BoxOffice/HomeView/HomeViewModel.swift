//
//  HomeViewModel.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/04.
//

import Foundation

protocol HomeViewModelInput {
    var date: String? { get }
    var itemPerPage: String? { get }
    var weekOption: WeekOption? { get }
}

protocol HomeViewModelOutput{
    var movieCellDatas: Observable<[MovieCellData]> { get }
    func requestData()
}

protocol HomeViewModel: HomeViewModelInput, HomeViewModelOutput {}

final class DefaultHomeViewModel: HomeViewModel {
    private(set) var date: String?
    private(set) var itemPerPage: String?
    private(set) var weekOption: WeekOption?
    
    var movieCellDatas = Observable<[MovieCellData]>([])
    
    func setupProperty(date: String, itemPerPage: String = "10", weekOption: WeekOption? = nil) {
        self.date = date
        self.itemPerPage = itemPerPage
        self.weekOption = weekOption
    }
    
    func requestData() {
        movieCellDatas.value = []
        fetchDailyBoxOfficeData { boxOfficeList in
            boxOfficeList.forEach { boxOffice in
                self.fetchMovieDetailInfo(with: boxOffice.movieCd) { movieName, openDate, productYear in
                    let openYear = String(openDate.prefix(4))
                    DispatchQueue.main.async {
                        self.fetchMoviePoster(with: movieName, year: openYear) { result in
                            switch result {
                            case .success(let url):
                                self.appendCellData(boxOffice: boxOffice, openDate: openDate, posterURL: url)
                            case .failure(_):
                                self.fetchMoviePoster(with: movieName, year: productYear) { result in
                                    switch result {
                                    case .success(let url):
                                        self.appendCellData(boxOffice: boxOffice, openDate: openDate, posterURL: url)
                                    case .failure(_):
                                        self.appendCellData(boxOffice: boxOffice, openDate: openDate, posterURL: nil)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }

    private func fetchDailyBoxOfficeData(_ completion: @escaping ([BoxOffice]) -> Void) {
        let searchDailyBoxOfficeListAPI = SearchDailyBoxOfficeListAPI(
            date: date!
        )
        searchDailyBoxOfficeListAPI.execute { result in
            switch result {
            case .success(let boxOfficeList):
                completion(boxOfficeList.boxOfficeResult.dailyBoxOfficeList!)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private func fetchMovieDetailInfo(
        with movieCode: String,
        _ completion: @escaping (_ movieName: String, _ openDate: String, _ productYear: String) -> Void
    ) {
        let searchMovieInfoAPI = SearchMovieInfoAPI(movieCode: movieCode)
        searchMovieInfoAPI.execute { result in
            switch result {
            case .success(let movieDetail):
                let movieName = movieDetail.movieInfoResult.movieInfo.movieNmEn
                let openDate = movieDetail.movieInfoResult.movieInfo.openDt
                let productYear = movieDetail.movieInfoResult.movieInfo.prdtYear
                completion(movieName, openDate, productYear)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    private func fetchMoviePoster(with movieName: String,
                                  year: String?,
                                  _ completion: @escaping (Result<URL, Error>) -> Void) {
        let searchMoviePosterAPI = SearchMoviePosterAPI(movieTitle: movieName, year: year)
        searchMoviePosterAPI.execute { result in
            switch result {
            case .success(let posterInfo):
                let url = URL(string: posterInfo.posterURLString())!
                completion(.success(url))
            case .failure(let error):
                print(String(describing: error))
                completion(.failure(error))
            }
        }
    }
    
    private func appendCellData(boxOffice: BoxOffice,
                                openDate: String,
                                posterURL: URL?) {
        movieCellDatas.value.append(
            MovieCellData(
                posterURL: posterURL ?? nil,
                currentRank: boxOffice.rank,
                totalAudience: boxOffice.audiAcc,
                title: boxOffice.movieNm,
                openDate: openDate,
                isNewEntry: boxOffice.rankOldAndNew == "NEW",
                rankChange: boxOffice.rankInten
            )
        )
    }
}
