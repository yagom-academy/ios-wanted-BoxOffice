//
//  MovieDetailViewModel.swift
//  BoxOffice
//
//  Created by 유한석 on 2023/01/06.
//

import Foundation

protocol MovieDetailViewModelProtocol {
    func fetchCurrentMovieDetail(movieBoxOfficeInfo: DailyBoxOfficeList)
    func createMoviePageInfo(movieBoxOfficeInfo: DailyBoxOfficeList, movieDetail: MovieDetail) -> MovieInfoPageModel
}

final class MovieDetailViewModel: MovieDetailViewModelProtocol {
    
    // Network
    let boxOfficeDirector = MovieRequestDirector()
    let networkManager = NetworkManager()

    // ViewModel Properties
    var currentPageMovieDetail: MovieInfoPageModel?
    
    //initializer
    init(selectedDailyMovie: DailyBoxOfficeList) {
        fetchCurrentMovieDetail(movieBoxOfficeInfo: selectedDailyMovie)
    }
    
    // method
    func fetchCurrentMovieDetail(movieBoxOfficeInfo: DailyBoxOfficeList) {
        let queryItems: [String: String] = [
            "movieCd": movieBoxOfficeInfo.movieCD
        ]
        
        guard let movieDetailRequest = boxOfficeDirector.createGetRequest(
            queryItems: queryItems,
            type: MovieRequestPath.movieDetail
        ) else {
            return
        }
        
        self.networkManager.executeDataTask(request: movieDetailRequest) { [weak self] (result: Result<Data, NetWorkError>) in
            switch result {
            case .success(let data):
                guard let movieDetailInfo = JSONDecoder().decode(from: data, to: MovieDetail.self) else {
                    return
                }
                let movieDetailPageInfo = self?.createMoviePageInfo(
                    movieBoxOfficeInfo: movieBoxOfficeInfo,
                    movieDetail: movieDetailInfo
                )
                
                DispatchQueue.main.async { [weak self] in
                    self?.currentPageMovieDetail = movieDetailPageInfo
                }
                
            case .failure(let failure):
                debugPrint("MovieDetailViewModel - fetchCurrentMovieDetail - NetworkError \(failure)")
            }
        }
    }
    
    func createMoviePageInfo(movieBoxOfficeInfo: DailyBoxOfficeList, movieDetail: MovieDetail) -> MovieInfoPageModel {
        return MovieInfoPageModel(
            rank: movieBoxOfficeInfo.rank,
            movieNm: movieBoxOfficeInfo.movieNm,
            openDatDt: movieBoxOfficeInfo.openDt,
            audiCnt: movieBoxOfficeInfo.audiCnt,
            audiInten: movieBoxOfficeInfo.audiInten,
            rankOldAndNew: movieBoxOfficeInfo.rankOldAndNew.rawValue,
            prdtYear: movieDetail.movieInfoResult.movieInfo.prdtYear,
            openYearDt: movieDetail.movieInfoResult.movieInfo.openDt,
            showTm: movieDetail.movieInfoResult.movieInfo.showTm,
            genreNm: movieDetail.movieInfoResult.movieInfo.genres[0].genreNm,
            directors: movieDetail.movieInfoResult.movieInfo.directors,
            actors: movieDetail.movieInfoResult.movieInfo.actors,
            watchGradeNm: movieDetail.movieInfoResult.movieInfo.audits[0].watchGradeNm
        )
    }
}
