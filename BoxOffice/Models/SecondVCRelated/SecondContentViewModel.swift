//
//  SecondContentViewModel.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/20.
//

import Foundation

class SecondContentViewModel: ObservableObject {
    
    // TODO: 1번째 화면에서 선택한 엔티티도 받아오도록 추가?
    //input
    var didReceiveEntity: (_ entity: KoficMovieDetailEntity, _ previousModel: FirstMovieCellModel) -> () = { entity, cellModel in }
    
    //output
    @Published var boxOfficeRank: (title: String, data: String) = (title: "", data: "")//박스오피스 순위
    @Published var movieName: (title: String, data: String) = (title: "", data: "") //영화명
    @Published var releasedDay: (title: String, data: String) = (title: "", data: "") //개봉일
    @Published var audCount: (title: String, data: String) = (title: "", data: "") //관객수
    @Published var rankIncrement: (title: String, data: String) = (title: "", data: "") //전일대비 순위의 증감분
    @Published var rankApproached: (title: String, data: String) = (title: "", data: "") //랭킹에 신규 진입 여부
    @Published var makedYear: (title: String, data: String) = (title: "", data: "") //제작연도
    @Published var releasedYear: (title: String, data: String) = (title: "", data: "") //개봉연도
    @Published var runningTime: (title: String, data: String) = (title: "", data: "") //상영시간
    @Published var genre: (title: String, data: [String]) = (title: "", data: []) //장르
    @Published var director:(title: String, data: [String]) = (title: "", data: []) //감독명
    @Published var actors:(title: String, data: [String]) = (title: "", data: []) //배우명
    @Published var restictionRate:(title: String, data: [String]) = (title: "", data: []) //관람등급 명칭
    
    //properties
    
    init() {
        bind()
    }
    
    private func bind() {
        didReceiveEntity = { [weak self] entity, cellModel in
            print("secondContentViewModel didReceiveEntity")
            guard let self = self else { return }
            
            self.populateEntity(result: entity, previousModel: cellModel)
        }
    }
    
    private func populateEntity(result: KoficMovieDetailEntity, previousModel: FirstMovieCellModel) {
        
        boxOfficeRank = (title: "박스오피스 랭크", data: previousModel.rank)
        let combinedName = "\(result.movieInfoResult.movieInfo.movieNmEn) / \(result.movieInfoResult.movieInfo.movieNm)"
        movieName = (title: "영화이름", data: combinedName)
        
        releasedDay = (title: "개봉일", data: previousModel.openDt)
        
        audCount = (title: "관객수", data: previousModel.audiCnt)
        rankIncrement = (title: "랭크증감", data: previousModel.rankInten)
        rankApproached = (title: "랭크신규진입", data: previousModel.rankOldAndNew)
        makedYear = (title: "제작년도", data: result.movieInfoResult.movieInfo.prdtYear)
        releasedYear = (title: "개봉년도", data: result.movieInfoResult.movieInfo.openDt)
        runningTime = (title: "상영시간", data: result.movieInfoResult.movieInfo.showTm)
        
        let genres = result.movieInfoResult.movieInfo.genres.map { genre in
            return genre.genreNm
        }
        
        genre = (title: "장르", data: genres)
        
        let directors = result.movieInfoResult.movieInfo.directors.map { director in
            return director.peopleNm
        }
        
        director = (title: "감독", data: directors)
        
        let actorNames = result.movieInfoResult.movieInfo.actors.map { actorData in
            actorData.peopleNm
        }
        
        actors = (title: "배우", data: actorNames)
        
        let audits = result.movieInfoResult.movieInfo.audits.map { audit in
            audit.watchGradeNm
        }
        
        restictionRate = (title: "관람등급", data: audits)
    }
}
