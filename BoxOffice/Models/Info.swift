//
//  Info.swift
//  BoxOffice
//
//  Created by 홍다희 on 2022/10/21.
//

import Foundation

struct Info: Hashable {

    let title: String
    let value: String

}

// MARK: - InfoConvertible

protocol InfoConvertible {

    var info: [Info] { get }

}

// MARK: MovieDetail

extension MovieDetail: InfoConvertible {

    var info: [Info] {
        [
            .init(title: "개봉", value: "\(openDate.year) 년"),
            .init(title: "제작", value: "\(productionDate) 년"),
            .init(title: "장르", value: genres.joined()),
            .init(title: "관람등급", value: watchGrade),
        ]
    }

}

// MARK: MovieRanking

extension MovieRanking: InfoConvertible {

    var info: [Info] {
        [
            .init(title: "순위", value: rankingDisplayText),
            .init(title: "신규진입", value: isNewRankingDisplayText),
            .init(title: "누적관객", value: numberOfMoviegoersDisplayText)
        ]
    }

    private var rankingDisplayText: String {
        var changeRankingDisplayText = changeRanking.string
        if changeRanking > 0 {
            changeRankingDisplayText = "+\(changeRanking.string)"
        } else if changeRanking == 0 {
            changeRankingDisplayText = "-"
        }
        return "\(ranking.string) (\(changeRankingDisplayText))"
    }

    private var isNewRankingDisplayText: String {
        if isNewRanking {
            return "Y"
        }
        return "N"
    }

    private var numberOfMoviegoersDisplayText: String {
        "\(numberOfMoviegoers.string) 명"
    }

}


