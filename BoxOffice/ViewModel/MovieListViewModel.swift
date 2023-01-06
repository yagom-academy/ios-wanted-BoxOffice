//
//  MovieListViewModel.swift
//  BoxOffice
//
//  Created by TORI on 2023/01/02.
//

import Foundation

final class MovieListViewModel {
    private let apiService = APIService()
    
    private var boxOfficeList = Observable([DailyBoxOfficeEntity.BoxOfficeResult.DailyBoxOfficeList]())
    private var movieInfoList = Observable([MovieInfoEntity]())
    private var moviePosterList = Observable([MoviePosterEntity]())
    
    var movieEssentialInfoList = Observable([MovieEssentialInfo]())
    var errorMessage = Observable("")
    
    init() {
        boxOfficeList.subscribe { [weak self] entity in
            var models = [MovieInfoEntity]()
            entity.forEach {
                self?.fetchMovieDetail(movieCd: $0.movieCd) { model in
                    models.append(model)
                    guard models.count == entity.count else { return }
                    self?.movieInfoList.value = models
                }
            }
        }
        
        movieInfoList.subscribe { [weak self] entity in
            entity.forEach {
                self?.fetchPoster(title: $0.movieInfoResult.movieInfo.movieNmEn)
            }
        }
        
        moviePosterList.subscribe { [weak self] entity in
            self?.configureMovieEssentialInfo()
        }
    }
    
    private func configureMovieEssentialInfo() {
        let sequenceZip = zip3(boxOfficeList.value,
                               movieInfoList.value,
                               moviePosterList.value)
        let models = sequenceZip.map {
            let boxOffice = $0.0
            let info = $0.1.movieInfoResult.movieInfo
            let poster = $0.2
            return MovieEssentialInfo(posterUrl: poster.poster,
                               rank: boxOffice.rank,
                               movieNm: boxOffice.movieNm,
                               openDt: boxOffice.openDt,
                               audiAcc: boxOffice.audiAcc,
                               rankInten: boxOffice.rankInten,
                               rankOldAndNew: boxOffice.rankOldAndNew,
                               prdtYear: info.prdtYear,
                               openYear: info.openDt,
                               showTm: info.showTm,
                                      genres: info.genres[0].genreNm,
                                      directors: info.directors,
                                      actors: info.actors,
                                      watchGradeNm: info.audits[0].watchGradeNm)
        }
        movieEssentialInfoList.value = models
    }
    
    func fetchBoxOffice(date: String) {
        apiService.fetchBoxOffice(date: date) { [weak self] result in
            switch result {
            case .success(let data):
                self?.boxOfficeList.value = data.boxOfficeResult.dailyBoxOfficeList
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    private func fetchMovieDetail(movieCd: String, completion: @escaping (MovieInfoEntity) -> Void) {
        apiService.fetchMovieDetail(movieCd: movieCd) { [weak self] result in
            switch result {
            case .success(let data):
                completion(data)
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
            }
        }
    }
    
    private func fetchPoster(title: String) {
        apiService.fetchPoster(title: title) { [weak self] result in
            switch result {
            case .success(let data):
                self?.moviePosterList.value.append(data)
            case .failure(let error):
                self?.errorMessage.value = error.localizedDescription
            }
        }
    }
}
