//
//  DummyCreater.swift
//  BoxOffice
//
//  Created by 유영훈 on 2022/10/18.
//

import Foundation
class Dummy {
    func getMovieInfo(_ completion: @escaping (MovieInfoModel) -> Void){
        let dummy = MovieInfoModel(movieNm: "에브리씽 에브리웨어 올 앳 원스", movieNmEn: "Everything Everywhere All At Once", movieNmOg: "", prdtYear: "2022", showTm: "139", openDt: "20221012", nations: [BoxOffice.Nation(nationNm: "미국")], genres: [BoxOffice.Genres(genreNm: "액션"), BoxOffice.Genres(genreNm: "코미디")], directors: [BoxOffice.Director(peopleNm: "다니엘 콴", peopleNmEn: "Dan KWAN"), BoxOffice.Director(peopleNm: "다니엘 쉐이너트", peopleNmEn: "Daniel SCHEINERT")], actors: [BoxOffice.Actor(peopleNm: "양자경", peopleNmEn: "Michelle Yeoh", cast: "", castEn: ""), BoxOffice.Actor(peopleNm: "스테파니 수", peopleNmEn: "Stephanie Hsu", cast: "", castEn: ""), BoxOffice.Actor(peopleNm: "키 호이 콴", peopleNmEn: "Ke Huy-Quan", cast: "", castEn: ""),BoxOffice.Actor(peopleNm: "키 호이 콴", peopleNmEn: "Ke Huy-Quan", cast: "", castEn: ""),BoxOffice.Actor(peopleNm: "키 호이 콴", peopleNmEn: "Ke Huy-Quan", cast: "", castEn: ""), BoxOffice.Actor(peopleNm: "제이미 리 커티스", peopleNmEn: "Jamie Lee Curtis", cast: "", castEn: "")], audits: [BoxOffice.Audit(auditNo: "2022-MF02367 ", watchGradeNm: "15세이상관람가")], dailyBoxOfficeInfo: BoxOfficeModel(rnum: "1", rank: "1", rankInten: "-3", rankOldAndNew: "NEW", movieCd: "20198317", movieNm: "인생은 아름다워", openDt: "2022-09-28", audiCnt: "17597", audiAcc: "18739263"))
        
        completion(dummy)
    }
    func getBoxOffice(_ completion: @escaping ([BoxOfficeModel]) -> Void) {
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 1.0) {
            let dummy = [BoxOfficeModel(rnum: "1", rank: "1", rankInten: "0", rankOldAndNew: "OLD", movieCd: "20198317", movieNm: "인생은 아름다워", openDt: "2022-09-28", audiCnt: "17597", audiAcc: "18739263"),
                         BoxOfficeModel(rnum: "2", rank: "2", rankInten: "0", rankOldAndNew: "OLD", movieCd: "20215601", movieNm: "공조2: 인터내셔날", openDt: "2022-09-07", audiCnt: "14466", audiAcc: "18739263"),
                         BoxOfficeModel(rnum: "3", rank: "3", rankInten: "3", rankOldAndNew: "OLD", movieCd: "20226798", movieNm: "에브리씽 에브리웨어 올 앳 원스", openDt: "2022-10-12", audiCnt: "8211", audiAcc: "18739263"),
                         BoxOfficeModel(rnum: "4", rank: "4", rankInten: "1", rankOldAndNew: "NEW", movieCd: "20219628", movieNm: "정직한 후보2", openDt: "2022-09-28", audiCnt: "7699", audiAcc: "18739263"),
                         BoxOfficeModel(rnum: "5", rank: "5", rankInten: "-1", rankOldAndNew: "OLD", movieCd: "20227304", movieNm: "오펀: 천사의 탄생", openDt: "2022-10-12", audiCnt: "7439", audiAcc: "18739263"),
                         BoxOfficeModel(rnum: "6", rank: "6", rankInten: "-3", rankOldAndNew: "OLD", movieCd: "20226777", movieNm: "극장판 짱구는 못말려: 수수께끼! 꽃피는 천하떡잎학교", openDt: "2022-09-28", audiCnt: "5805", audiAcc: "18739263"),
                         BoxOfficeModel(rnum: "7", rank: "7", rankInten: "0", rankOldAndNew: "NEW", movieCd: "20208101", movieNm: "대무가", openDt: "2022-10-12", audiCnt: "4782", audiAcc: "18739263"),
                         BoxOfficeModel(rnum: "8", rank: "8", rankInten: "0", rankOldAndNew: "NEW", movieCd: "20198461", movieNm: "리멤버", openDt: "2022-10-26", audiCnt: "3647", audiAcc: "18739263"),
                         BoxOfficeModel(rnum: "9", rank: "9", rankInten: "-1", rankOldAndNew: "OLD", movieCd: "20227338", movieNm: "티켓 투 파라다이스", openDt: "2022-10-12", audiCnt: "3137", audiAcc: "18739263"),
                          BoxOfficeModel(rnum: "10", rank: "10", rankInten: "0", rankOldAndNew: "OLD", movieCd: "20225729", movieNm: "스마일", openDt: "2022-10-06", audiCnt: "1728", audiAcc: "18739263")]
            completion(dummy)
        }
    }
}
