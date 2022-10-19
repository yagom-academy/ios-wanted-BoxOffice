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
    var didReceiveEntity: (KoficMovieDetailEntity) -> () = { entity in }
    
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
    private var genre: String = "" //장르
    private var director: String = "" //감독명
    
    // TODO: 배열로 처리해야 할 것들 전부 확인 후 수정
    private var actors: String = "" //배우명
    private var restictionRate: String = "" //관람등급 명칭
    
    init() {
        bind()
    }
    
    private func bind() {
        didReceiveEntity = { [weak self] entity in
            print("secondContentViewModel didReceiveEntity")
            guard let self = self else { return }
            
            self.populateEntity(result: entity)
            self.didReceiveViewModel?(())
        }
    }
    
    private func populateEntity(result: KoficMovieDetailEntity) {
        
        print("secondContentViewModel populate Entity")
        
        boxOfficeRank = "boxOfficeRank"
        
        let combinedName = "\(result.movieInfoResult.movieInfo.movieNmEn) / \(result.movieInfoResult.movieInfo.movieNm)"
        movieName = combinedName
        releasedDay = "releasedDay"
        audCount = "audCount"
        rankIncrement = "rankIncrement"
        rankApproached = "rankApproached"
        makedYear = result.movieInfoResult.movieInfo.prdtYear
        releasedYear = result.movieInfoResult.movieInfo.openDt
        runningTime = result.movieInfoResult.movieInfo.showTm
        genre = "genre"
        director = "director"
        actors = "actors"
        restictionRate = "watchGrade"
        
        let boxOfficeRankData = TempDataType(name: "박스오피스 랭크", data: boxOfficeRank)
        let movieNameData = TempDataType(name: "영화이름", data: movieName)
        let releasedDayData = TempDataType(name: "개봉일", data: releasedDay)
        let audCountData = TempDataType(name: "관객수", data: audCount)
        let rankIncrementData = TempDataType(name: "랭크증감", data: rankIncrement)
        let rankApproachedData = TempDataType(name: "랭크신규진입", data: rankApproached)
        let makedYearData = TempDataType(name: "제작년도", data: makedYear)
        let releasedYearData = TempDataType(name: "개봉년도", data: releasedYear)
        let runningTimeData = TempDataType(name: "상영시간", data: runningTime)
        let genreData = TempDataType(name: "장르", data: genre)
        let directorData = TempDataType(name: "감독", data: director)
        let actorsData = TempDataType(name: "배우", data: actors)
        let restictionRateData = TempDataType(name: "관람등급", data: restictionRate)
        
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
