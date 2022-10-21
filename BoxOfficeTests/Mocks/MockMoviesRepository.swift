//
//  MockRepository.swift
//  BoxOfficeTests
//
//  Created by channy on 2022/10/21.
//

import Foundation

class MockMoviesRepository: MoviesRepository {

    func fetchMoviesList(completion: @escaping ((Result<[Movie], RepositoryError>) -> Void)) {
        let testMovieList = 
            [Movie(rank: "1", movieNm: "블랙 아담", openDt: "2022-10-19", audiAcc: "51945", rankInten: "0", rankOldAndNew: "OLD", movieCd: "20226886"),
             Movie(rank: "2", movieNm: "인생은 아름다워", openDt: "2022-09-28", audiAcc: "237113", rankInten: "0", rankOldAndNew: "OLD", movieCd: "20198317"),
             Movie(rank: "3", movieNm: "에브리씽 에브리웨어 올 앳 원스", openDt: "2022-10-12", audiAcc: "40100", rankInten: "1", rankOldAndNew: "OLD", movieCd: "20226798"),
             Movie(rank: "4", movieNm: "공조2: 인터내셔날", openDt: "2022-09-07", audiAcc: "1417827", rankInten: "1", rankOldAndNew: "OLD", movieCd: "20215601"),
             Movie(rank: "5", movieNm: "오펀: 천사의 탄생", openDt: "2022-10-12", audiAcc: "37276", rankInten: "1", rankOldAndNew: "OLD", movieCd: "20227304"),
             Movie(rank: "6", movieNm: "극장판 짱구는 못말려: 수수께끼! 꽃피는 천하떡잎학교", openDt: "2022-09-28", audiAcc: "96786", rankInten: "2", rankOldAndNew: "OLD", movieCd: "20226777"),
             Movie(rank: "7", movieNm: "정직한 후보2", openDt: "2022-09-28", audiAcc: "189319", rankInten: "5", rankOldAndNew: "OLD", movieCd: "20219628"),
             Movie(rank: "8", movieNm: "스마일", openDt: "2022-10-06", audiAcc: "32222", rankInten: "-1", rankOldAndNew: "OLD", movieCd: "20225729"),
             Movie(rank: "9", movieNm: "귀못", openDt: "2022-10-19", audiAcc: "5572", rankInten: "0", rankOldAndNew: "OLD", movieCd: "20227225"),
             Movie(rank: "10", movieNm: "대무가", openDt: "2022-10-12", audiAcc: "22025", rankInten: "0", rankOldAndNew: "OLD", movieCd: "20208101")]
        
        completion(.success(testMovieList))
    }
    
    func fetchMoviesDetail(movieId movieCd: String, completion: @escaping ((Result<MovieDetail, RepositoryError>) -> Void)) {
        completion(.failure(.networkError))
    }
}
