//
//  MockRepository.swift
//  BoxOfficeTests
//
//  Created by channy on 2022/10/21.
//

import Foundation

class MockMoviesRepository: MoviesRepository {
    func fetchMoviesList(completion: @escaping ((Result<[Movie], RepositoryError>) -> Void)) {
        let testMovieList = [
            Movie(rank: "1", movieNm: "블랙 아담", openDt: "2022-10-19", audiAcc: "33458", rankInten: "0", rankOldAndNew: "OLD"),
            Movie(rank: "2", movieNm: "인생은 아름다워", openDt: "2022-09-28", audiAcc: "232294", rankInten: "0", rankOldAndNew: "OLD"),
            Movie(rank: "3", movieNm: "리멤버", openDt: "2022-10-26", audiAcc: "8737", rankInten: "0", rankOldAndNew: "NEW"),
            Movie(rank: "4", movieNm: "에브리씽 에브리웨어 올 앳 원스", openDt: "2022-10-12", audiAcc: "35969", rankInten: "0", rankOldAndNew: "OLD"),
            Movie(rank: "5", movieNm: "공조2: 인터내셔날", openDt: "2022-09-07", audiAcc: "1413827", rankInten: "-2", rankOldAndNew: "OLD"),
            Movie(rank: "6", movieNm: "오펀: 천사의 탄생", openDt: "2022-10-12", audiAcc: "35008", rankInten: "1", rankOldAndNew: "OLD"),
            Movie(rank: "7", movieNm: "극장판 짱구는 못말려: 수수께끼! 꽃피는 천하떡잎학교", openDt: "2022-09-28", audiAcc: "95381", rankInten: "1", rankOldAndNew: "OLD"),
            Movie(rank: "8", movieNm: "귀못", openDt: "2022-10-19", audiAcc: "4598", rankInten: "-3", rankOldAndNew: "OLD"),
            Movie(rank: "9", movieNm: "가재가 노래하는 곳", openDt: "2022-11-02", audiAcc: "1086", rankInten: "0", rankOldAndNew: "NEW"),
            Movie(rank: "9", movieNm: "스마일", openDt: "2022-10-06", audiAcc: "30997", rankInten: "-3", rankOldAndNew: "OLD")]
        
        completion(.success(testMovieList))
    }
    
    
}
