//
//  SecondContentViewModel.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/20.
//

import Foundation

struct TempDataType: Identifiable {
    var name: String
    var data: String
    var id = UUID()
}

class SecondContentViewModel: ObservableObject {
    
    // TODO: 1번째 화면에서 선택한 엔티티도 받아오도록 추가?
    //input
    var didReceiveEntity: (_ entity: KoficMovieDetailEntity, _ previousModel: FirstMovieCellModel) -> () = { entity, cellModel in }
    
    //output
    @MainThreadActor var didReceiveViewModel: ( ((Void)) -> () )?
    
    // TODO: 스레드 문제 해결...
    @Published var dataSource: [TempDataType] = []
    
    //properties
    private var boxOfficeRank: String = ""//박스오피스 순위
    private var movieName: String = "" //영화명
    private var releasedDay: String = "" //개봉일
    private var audCount: String = "" //관객수
    private var rankIncrement: String = "" //전일대비 순위의 증감분
    private var rankApproached: String = "" //랭킹에 신규 진입 여부
    private var makedYear: String = "" //제작연도
    private var releasedYear: String = "" //개봉연도
    private var runningTime: String = "" //상영시간
    private var genre: [String] = [] //장르
    private var director: [String] = [] //감독명
    private var actors: [String] = [] //배우명
    private var restictionRate: [String] = [] //관람등급 명칭
    
    init() {
        bind()
    }
    
    private func bind() {
        didReceiveEntity = { [weak self] entity, cellModel in
            print("secondContentViewModel didReceiveEntity")
            guard let self = self else { return }
            
            self.populateEntity(result: entity, previousModel: cellModel)
            self.didReceiveViewModel?(())
        }
    }
    
    private func populateEntity(result: KoficMovieDetailEntity, previousModel: FirstMovieCellModel) {
        
        print("secondContentViewModel populate Entity")
        
        boxOfficeRank = previousModel.rank
        
        let combinedName = "\(result.movieInfoResult.movieInfo.movieNmEn) / \(result.movieInfoResult.movieInfo.movieNm)"
        movieName = combinedName
        releasedDay = previousModel.openDt
        audCount = previousModel.audiCnt
        rankIncrement = previousModel.rankInten
        rankApproached = previousModel.rankOldAndNew
        makedYear = result.movieInfoResult.movieInfo.prdtYear
        releasedYear = result.movieInfoResult.movieInfo.openDt
        runningTime = result.movieInfoResult.movieInfo.showTm
        
        genre = result.movieInfoResult.movieInfo.genres.map { genre in
            return genre.genreNm
        }
        
        director = result.movieInfoResult.movieInfo.directors.map { director in
            return director.peopleNm
        }
        
        actors = result.movieInfoResult.movieInfo.actors.map { actorData in
            actorData.peopleNm
        }
        
        restictionRate = result.movieInfoResult.movieInfo.audits.map { audit in
            audit.watchGradeNm
        }
        
        let boxOfficeRankData = TempDataType(name: "박스오피스 랭크", data: boxOfficeRank)
        let movieNameData = TempDataType(name: "영화이름", data: movieName)
        let releasedDayData = TempDataType(name: "개봉일", data: releasedDay)
        let audCountData = TempDataType(name: "관객수", data: audCount)
        let rankIncrementData = TempDataType(name: "랭크증감", data: rankIncrement)
        let rankApproachedData = TempDataType(name: "랭크신규진입", data: rankApproached)
        let makedYearData = TempDataType(name: "제작년도", data: makedYear)
        let releasedYearData = TempDataType(name: "개봉년도", data: releasedYear)
        let runningTimeData = TempDataType(name: "상영시간", data: runningTime)
        // TODO: swiftUI 메인스레드 문제 고치면서 데이터 넣는 방법, LazyVstack 들어간 것도 다른 방식으로 수정...
        let genreData = TempDataType(name: "장르", data: genre.first ?? "")
        let directorData = TempDataType(name: "감독", data: director.first ?? "")
        let actorsData = TempDataType(name: "배우", data: actors.first ?? "")
        let restictionRateData = TempDataType(name: "관람등급", data: restictionRate.first ?? "")
        
        dataSource.append(boxOfficeRankData)
        dataSource.append(movieNameData)
        dataSource.append(releasedDayData)
        dataSource.append(audCountData)
        dataSource.append(rankIncrementData)
        dataSource.append(rankApproachedData)
        dataSource.append(makedYearData)
        dataSource.append(releasedYearData)
        dataSource.append(releasedDayData)
        dataSource.append(runningTimeData)
        dataSource.append(genreData)
        dataSource.append(directorData)
        dataSource.append(actorsData)
        dataSource.append(restictionRateData)
    }
}
