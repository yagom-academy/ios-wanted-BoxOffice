//
//  FirstMovieCellModel.swift
//  BoxOffice
//
//  Created by pablo.jee on 2022/10/18.
//

import Foundation

class FirstMovieCellModel {
    
    //input
    var shouldModelRequestImage: () -> () = {  }
    
    //output
    var propergateImageURL: ((String, String) -> ())?
    
    //properties
    var rnum, rank, rankInten: String
    var rankOldAndNew: String
    var movieCd, movieNm, openDt, salesAmt: String
    var salesShare, salesInten, salesChange, salesAcc: String
    var audiCnt, audiInten, audiChange, audiAcc: String
    var scrnCnt, showCnt: String
    
    var repository: RepositoryProtocol = Repository(httpClient: HTTPClient())
    
    init() {
        self.rnum = "" //순번을 출력
        self.rank = "" //해당일자의 박스오피스 순위를 출력
        self.rankInten = "" //전일 대비 순위의 증감분
        self.rankOldAndNew = "" //랭킹에 신규진입여부를 출력 OLD: 기존, NEW: 신규
        self.movieCd = "" //영화의 대표코드
        self.movieNm = "" //영화명 국문
        self.openDt = "" //영화 개봉일
        self.salesAmt = "" //해당일의 매출액
        self.salesShare = "" //해당일자 상영작의 매출총액 대비 해당 영화의 매출비율
        self.salesInten = "" //전일 대비 매출액 증감분
        self.salesChange = "" //전일 대비 매출액 증감 비율
        self.salesAcc = "" //누적매출액
        self.audiCnt = "" //해당일의 관객수
        self.audiInten = "" //전일 대비 관객수 증감분
        self.audiChange = "" //전일 대비 관객수 증감 비율
        self.audiAcc = "" //누적관객수
        self.scrnCnt = "" //해당일자에 상영한 스크린 수
        self.showCnt = "" //해당일자에 상영된 횟수
        
        bind()
    }
    
    private func bind() {
        shouldModelRequestImage = { [weak self] in
            guard let self = self else { return }
            
            Task {
                guard let imageURLString = await self.requestImage() else { return }
                print("5 \(imageURLString)")
                self.propergateImageURL?(imageURLString, self.movieNm)
            }
        }
    }
    
    func requestImage() async -> String? {
        
        do {
            let entity: KoficMovieDetailEntity = try await repository.fetch(api: .kofic(.detailMovieInfo(movieCd: movieCd)))
            print("1")
            let movieName = entity.movieInfoResult.movieInfo.movieNmEn
            print("2 \(movieName)")
            let releasedYear = entity.movieInfoResult.movieInfo.openDt.koficDateToYear() ?? "2022"
            print("3 \(releasedYear)")
            let imageEntity: OmdbEntity = try await repository.fetch(api: .omdb(movieName: movieName, releasedYear: releasedYear))
            print("4 \(imageEntity.poster)")
            return imageEntity.poster
        } catch let error {
            let error = error as? HTTPError
            print(error)
            return nil
        }
    }
    
}
