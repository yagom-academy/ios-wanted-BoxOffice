//
//  MovieAPIUseCase.swift
//  BoxOffice
//
//  Created by 이원빈 on 2023/01/05.
//

import Foundation

struct MovieAPIUseCase {
    
    func requestDailyData(with date: String, in dataList: Observable<[MovieCellData]>) {
        dataList.value = []
        fetchDailyBoxOfficeData(with: date) { boxOfficeList in
            boxOfficeList.forEach { boxOffice in
                self.fetchMovieDetailInfo(with: boxOffice.movieCd) { movieName, openDate, productYear in
                    let openYear = String(openDate.prefix(4))
                    DispatchQueue.main.async {
                        self.fetchMoviePoster(with: movieName, year: openYear) { result in
                            switch result {
                            case .success(let url):
                                self.appendCellData(to: dataList,
                                                    boxOffice: boxOffice,
                                                    openDate: openDate,
                                                    posterURL: url)
                            case .failure(_):
                                self.fetchMoviePoster(with: movieName, year: productYear) { result in
                                    switch result {
                                    case .success(let url):
                                        self.appendCellData(to: dataList,
                                                            boxOffice: boxOffice,
                                                            openDate: openDate,
                                                            posterURL: url)
                                    case .failure(_):
                                        self.appendCellData(to: dataList,
                                                            boxOffice: boxOffice,
                                                            openDate: openDate,
                                                            posterURL: nil)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func requestAllWeekData(with date: String, in dataList: Observable<[MovieCellData]>) {
        dataList.value = []
        fetchAllWeekBoxOfficeData(with: date) { boxOfficeList in
            boxOfficeList.forEach { boxOffice in
                self.fetchMovieDetailInfo(with: boxOffice.movieCd) { movieName, openDate, productYear in
                    let openYear = String(openDate.prefix(4))
                    DispatchQueue.main.async {
                        self.fetchMoviePoster(with: movieName, year: openYear) { result in
                            switch result {
                            case .success(let url):
                                self.appendCellData(to: dataList,
                                                    boxOffice: boxOffice,
                                                    openDate: openDate,
                                                    posterURL: url)
                            case .failure(_):
                                self.fetchMoviePoster(with: movieName, year: productYear) { result in
                                    switch result {
                                    case .success(let url):
                                        self.appendCellData(to: dataList,
                                                            boxOffice: boxOffice,
                                                            openDate: openDate,
                                                            posterURL: url)
                                    case .failure(_):
                                        self.appendCellData(to: dataList,
                                                            boxOffice: boxOffice,
                                                            openDate: openDate,
                                                            posterURL: nil)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    
    func requestWeekEndData(with date: String, in dataList: Observable<[MovieCellData]>) {
        dataList.value = []
        fetchWeekEndBoxOfficeData(with: date) { boxOfficeList in
            boxOfficeList.forEach { boxOffice in
                self.fetchMovieDetailInfo(with: boxOffice.movieCd) { movieName, openDate, productYear in
                    let openYear = String(openDate.prefix(4))
                    DispatchQueue.main.async {
                        self.fetchMoviePoster(with: movieName, year: openYear) { result in
                            switch result {
                            case .success(let url):
                                self.appendCellData(to: dataList,
                                                    boxOffice: boxOffice,
                                                    openDate: openDate,
                                                    posterURL: url)
                            case .failure(_):
                                self.fetchMoviePoster(with: movieName, year: productYear) { result in
                                    switch result {
                                    case .success(let url):
                                        self.appendCellData(to: dataList,
                                                            boxOffice: boxOffice,
                                                            openDate: openDate,
                                                            posterURL: url)
                                    case .failure(_):
                                        self.appendCellData(to: dataList,
                                                            boxOffice: boxOffice,
                                                            openDate: openDate,
                                                            posterURL: nil)
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
}

private extension MovieAPIUseCase {
    func fetchAllWeekBoxOfficeData(with date: String,
                                          _ completion: @escaping ([BoxOffice]) -> Void) {
        let searchWeeklyBoxOfficeListAPI = SearchWeeklyBoxOfficeListAPI(
            date: date,
            weekOption: .allWeek
        )
        searchWeeklyBoxOfficeListAPI.execute { result in
            switch result {
            case .success(let boxOfficeList):
                guard let weeklyBoxOfficeList = boxOfficeList.boxOfficeResult.weeklyBoxOfficeList else {
                    return
                }
                completion(weeklyBoxOfficeList)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func fetchWeekEndBoxOfficeData(with date: String,
                                          _ completion: @escaping ([BoxOffice]) -> Void) {
        let searchWeeklyBoxOfficeListAPI = SearchWeeklyBoxOfficeListAPI(
            date: date,
            weekOption: .weekEnd
        )
        searchWeeklyBoxOfficeListAPI.execute { result in
            switch result {
            case .success(let boxOfficeList):
                guard let weeklyBoxOfficeList = boxOfficeList.boxOfficeResult.weeklyBoxOfficeList else {
                    return
                }
                completion(weeklyBoxOfficeList)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func fetchDailyBoxOfficeData(with date: String,
                                         _ completion: @escaping ([BoxOffice]) -> Void) {
        let searchDailyBoxOfficeListAPI = SearchDailyBoxOfficeListAPI(
            date: date
        )
        searchDailyBoxOfficeListAPI.execute { result in
            switch result {
            case .success(let boxOfficeList):
                guard let dailyBoxOfficeList = boxOfficeList.boxOfficeResult.dailyBoxOfficeList else {
                    return
                }
                completion(dailyBoxOfficeList)
            case .failure(let error):
                print(String(describing: error))
            }
        }
    }
    
    func fetchMovieDetailInfo(
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
    
    func fetchMoviePoster(with movieName: String,
                                  year: String?,
                                  _ completion: @escaping (Result<URL?, Error>) -> Void) {
        let searchMoviePosterAPI = SearchMoviePosterAPI(movieTitle: movieName, year: year)
        searchMoviePosterAPI.execute { result in
            switch result {
            case .success(let posterInfo):
                let url = URL(string: posterInfo.posterURLString())
                completion(.success(url))
            case .failure(let error):
                print(String(describing: error))
                completion(.failure(error))
            }
        }
    }
    
    func appendCellData(
        to list: Observable<[MovieCellData]>,
        boxOffice: BoxOffice,
        openDate: String,
        posterURL: URL?
    ) {
        list.value.append(
            MovieCellData(
                uuid: UUID(),
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
