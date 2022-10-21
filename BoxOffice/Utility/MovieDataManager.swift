//
//  ConvertManager.swift
//  BoxOffice
//
//  Created by sole on 2022/10/21.
//

import Foundation

enum MovieDataManager {
    static func convertToMovieType(main: KobisDailyBoxOfficeList, detail: KobisMovieInfo, asset: TmdbAsset?) throws -> Movie {
        guard let rank = Int(main.rank),
              let ratio = Int(main.ratioComparedToYesterday),
              let dailyAudience = Int(main.dailyAudience),
              let totalAudience = Int(main.totlaAudience),
              let productionYear = Int(detail.produnctionYear),
              let runningTime = Int(detail.runningTime),
              let watchGrade = detail.audits.first?.watchGrade else {
            print("movie type으로 전환하지 못함")
            throw ConvertError.toMovieType
        }
        let movie = Movie(id: asset?.id,
                          posterPath: asset?.posterPath,
                          backdropPath: asset?.backdropPath,
                          rank: rank,
                          ratioComparedToYesterday: ratio,
                          isNewInRank: main.isNewInRank,
                          name: main.movieName,
                          nameInEnglish: detail.nameInEnglish,
                          releasedDate: try main.releasedDate.convertToDateType(),
                          dailyAudience: dailyAudience,
                          totalAudience: totalAudience,
                          content: asset?.plot,
                          productionYear: productionYear,
                          runningTime: runningTime,
                          genres: detail.genres.map { $0.name }.joined(separator: ", "),
                          directors: detail.directors.map { $0.name }.joined(separator: ", "),
                          actors: detail.actors.map { $0.name }.joined(separator: ", "),
                          watchGrade: watchGrade)
        return movie
    }
    
    static func searchItems(_ items: [MainItem], for section: MainSection) -> [MainItem] {
        switch section {
        case .banner:
            return items.filter { $0.type == "banner" }
        case .ranking:
            return items.filter { $0.type == "ranking" }
        }
    }
    
    static func searchItems(_ items: [DetailItem], for section: DetailSection) -> [DetailItem] {
        switch section {
        case .main:
            return items.filter { $0.type == "mainInfo" }
        case .plot:
            return items.filter { $0.type == "plotInfo" }
        case .detail:
            return items.filter { $0.type == "detailInfo" }
        }
    }
    
    static func convertDetailItemType(from movie: Movie) -> [DetailItem] {
        let main: DetailItem = .mainInfo(MainInfo(id: movie.id,
                                                  posterPath: movie.posterPath,
                                                  backdropPath: movie.backdropPath,
                                                  rank: movie.rank,
                                                  ratioComparedToYesterday: movie.ratioComparedToYesterday,
                                                  isNewInRank: movie.isNewInRank,
                                                  name: movie.name,
                                                  nameInEnglish: movie.nameInEnglish,
                                                  releasedDate: movie.releasedDate,
                                                  dailyAudience: movie.dailyAudience,
                                                  totalAudience: movie.totalAudience))
        let plot: DetailItem = .plotInfo(PlotInfo(content: movie.content))
        let detail: DetailItem = .detailInfo(DetailInfo(productionYear: movie.productionYear,
                                                        releasedYear: movie.releasedDate.year,
                                                        runningTime: movie.runningTime,
                                                        genres: movie.genres,
                                                        directors: movie.directors,
                                                        actors: movie.actors,
                                                        watchGrade: movie.watchGrade))
        return [main, plot, detail]
    }
}
