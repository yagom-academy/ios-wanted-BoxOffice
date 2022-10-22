//
//  BoxOfficeHelper.swift
//  BoxOffice
//
//  Created by KangMingyo on 2022/10/21.
//

import Foundation

struct BoxOfficeHelper {
    
    //어제 날짜 구하기
    func yesterdayDate() -> String {
        let now = Date()
        let yesterday = now.addingTimeInterval(3600 * -24)
        
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyyMMdd"
        
        let yesterdayData = formatter.string(from: yesterday)
        
        return yesterdayData
    }
    
    // 누적 관객 수 만 단위로 변경
    func audiAccCal(_ audiAcc: String) -> String {
        if 10000 <= Int(audiAcc) ?? 0 {
            let audiAccNum = (Int(audiAcc) ?? 0) / 10000
            return "\(audiAccNum)만"
        } else {
            return audiAcc
        }
    }
    
    // 전일 대비 증감 계산
    func rankIntenCal(_ rankInten: String) -> String {
        if rankInten == "0" {
            return "-"
        } else if 0 < Int(rankInten) ?? 0 {
            return "🔺\(rankInten)"
        } else {
            return "🔻\(abs(Int(rankInten) ?? 0))"
        }
    }
    
    // 관람 등급 이미지
    func auditsImage(_ audits: String) -> String {
        if audits == "전체관람가" {
            return "zero"
        } else if audits == "12세이상관람가" {
            return "twelve"
        } else if audits == "15세이상관람가" {
            return "fifteen"
        } else {
            return "nineteen"
        }
    }

    // 배우 이름
    func actorNameHelper(_ actors: [Actors]) -> String {
        var actorArr = ""
        if actors.count != 0 {
            for i in 0..<actors.count-1 {
                actorArr += ("\(actors[i].peopleNm), ")
            }
            actorArr += ("\(actors[actors.count-1].peopleNm)")
        }
        return actorArr
    }
    
    // 영화 이름 띄어쓰기 때문에 Poster 못 불러오는거 
    func movieNameHelper(_ movieName: String) -> String {
        if movieName == "스마일" {
            return "Smile"
        } else if movieName == "공조2: 인터내셔날" {
            return "공조 2: 인터내셔날"
        } else if movieName == "정직한 후보2" {
            return "정직한 후보 2"
        } else {
            return movieName
        }
    }
}
