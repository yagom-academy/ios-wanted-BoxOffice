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
    var didReceiveEntity: (_ entity: KoficMovieDetailEntity, _ previousEntity: DailyBoxOfficeList) -> () = { entity, previousEntity in }
    @Published var didTapShareButton = { }
    @Published var didTapReviewButton = { }
    
    //output
    var propergateDidTapShareButton: (String) -> () = { info in }
    var propergateDidTapReviewButton = { }
    
    @Published var boxOfficeRank: (title: String, data: String) = (title: "박스오피스 랭크", data: "")//박스오피스 순위
    @Published var movieName: (title: String, data: String) = (title: "영화이름", data: "") //영화명
    @Published var releasedDay: (title: String, data: String) = (title: "개봉일", data: "") //개봉일
    @Published var audCount: (title: String, data: String) = (title: "관객수", data: "") //관객수
    @Published var rankIncrement: (title: String, data: String) = (title: "랭크증감", data: "") //전일대비 순위의 증감분
    @Published var rankApproached: (title: String, data: String) = (title: "랭크신규진입", data: "") //랭킹에 신규 진입 여부
    @Published var makedYear: (title: String, data: String) = (title: "제작연도", data: "") //제작연도
    @Published var releasedYear: (title: String, data: String) = (title: "개봉연도", data: "") //개봉연도
    @Published var runningTime: (title: String, data: String) = (title: "상영시간", data: "") //상영시간
    @Published var genre: (title: String, data: [String]) = (title: "장르", data: []) //장르
    @Published var director:(title: String, data: [String]) = (title: "감독명", data: []) //감독명
    @Published var actors:(title: String, data: [String]) = (title: "배우명", data: []) //배우명
    @Published var restictionRate:(title: String, data: [String]) = (title: "관람등급 명칭", data: []) //관람등급 명칭
    
    //properties
    
    init() {
        bind()
    }
    
    private func bind() {
        didReceiveEntity = { [weak self] entity, cellModel in
            print("secondContentViewModel didReceiveEntity")
            guard let self = self else { return }
            
            //TODO: GCD아닌 다른 방법으로 처리 고민
            DispatchQueue.main.async {
                self.populateEntity(result: entity, previousEntity: cellModel)
            }
        }
        
        didTapShareButton = { [weak self] in
            guard let self = self else { return }
            print("didTapButton Tapped")
            let info = self.gatherInfoForSharing()
            self.propergateDidTapShareButton(info)
        }
        
        didTapReviewButton = { [weak self] in
            guard let self = self else { return }
            self.propergateDidTapReviewButton()
        }
    }
    
    private func gatherInfoForSharing() -> String {
        
        let joinedGenre = genre.data.joined(separator: "-")
        let joinedDirector = director.data.joined(separator: "-")
        let joinedActor = actors.data.joined(separator: "-")
        let joinedRestrictionRate = restictionRate.data.joined(separator: "-")
        
        let info = """
                \(boxOfficeRank.title) : \(boxOfficeRank.data)
                \(movieName.title) : \(movieName.data)
                \(releasedDay.title) : \(releasedDay.data)
                \(audCount.title) : \(audCount.data)
                \(rankIncrement.title) : \(rankIncrement.data)
                \(rankApproached.title) : \(rankApproached.data)
                \(makedYear.title) : \(makedYear.data)
                \(releasedYear.title) : \(releasedYear.data)
                \(runningTime.title) : \(runningTime.data)
                \(genre.title) : \(joinedGenre)
                \(director.title) : \(joinedDirector)
                \(actors.title) : \(joinedActor)
                \(restictionRate.title) : \(joinedRestrictionRate)
        """
        
        return info
    }
    
    private func populateEntity(result: KoficMovieDetailEntity, previousEntity: DailyBoxOfficeList) {
        
        boxOfficeRank = (title: String.emojiAndTitle(emojiValue: .boxOfficeRank), data: previousEntity.rank)
        let combinedName = "\(result.movieInfoResult.movieInfo.movieNmEn) \n \(result.movieInfoResult.movieInfo.movieNm)"
        movieName = (title: String.emojiAndTitle(emojiValue: .movieName), data: combinedName)
        
        releasedDay = (title: String.emojiAndTitle(emojiValue: .releasedDay), data: previousEntity.openDt)
        
        audCount = (title: String.emojiAndTitle(emojiValue: .audCount), data: previousEntity.audiCnt)
        rankIncrement = (title: String.emojiAndTitle(emojiValue: .rankIncrement), data: previousEntity.rankInten)
        rankApproached = (title: String.emojiAndTitle(emojiValue: .rankApproach), data: previousEntity.rankOldAndNew.rawValue)
        makedYear = (title: String.emojiAndTitle(emojiValue: .makedYear), data: result.movieInfoResult.movieInfo.prdtYear)
        releasedYear = (title: String.emojiAndTitle(emojiValue: .releasedYear), data: result.movieInfoResult.movieInfo.openDt)
        runningTime = (title: String.emojiAndTitle(emojiValue: .runningTime), data: result.movieInfoResult.movieInfo.showTm)
        
        let genres = result.movieInfoResult.movieInfo.genres.map { genre in
            return genre.genreNm
        }
        
        genre = (title: String.emojiAndTitle(emojiValue: .genres), data: genres)
        
        let directors = result.movieInfoResult.movieInfo.directors.map { director in
            return director.peopleNm
        }
        
        director = (title: String.emojiAndTitle(emojiValue: .directors), data: directors)
        
        let actorNames = result.movieInfoResult.movieInfo.actors.map { actorData in
            actorData.peopleNm
        }
        
        actors = (title: String.emojiAndTitle(emojiValue: .actors), data: actorNames)
        
        let audits = result.movieInfoResult.movieInfo.audits.map { audit in
            audit.watchGradeNm
        }
        
        restictionRate = (title: String.emojiAndTitle(emojiValue: .restrictionRate), data: audits)
    }
}
