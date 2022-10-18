//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/19.
//

import Foundation

protocol NetworkDelegate {
  func didUpdateBoxOfficeList(_ _dailyList: [DailyListObject])
  func didUpdateMovieInfo(_ _movieInfo: MovieInfo, _ index: Int)
}

enum BoxOfficeType: String {
  case daily = "boxoffice/searchDailyBoxOfficeList.json"
  case weekly = "boxoffice/searchWeeklyBoxOfficeList.json"
}

private let urlKobis = "https://www.kobis.or.kr/kobisopenapi/webservice/rest/"
private let urlOmdb = "https://www.omdbapi.com/"
private let decoder = JSONDecoder()

struct NetworkManager {
  var delegate: NetworkDelegate?

  // MARK: - Fetch Data

  func fetchBoxOffice(targetDate: String, type: BoxOfficeType) {
    var url = urlKobis
    let query = "?targetDt=\(targetDate)&wideAreaCd=0105001&key=\(Bundle.main.kobisKey)"

    switch type {
    case .daily:
      url += type.rawValue + query
    case .weekly:
      url += type.rawValue + query
    }

    self.performBoxOfficeRequest(urlString: url)
  }

  func fetchMovieInfo(movieCode: String, index: Int) {
    var url = urlKobis + "movie/searchMovieInfo.json"
    let query = "?key=\(Bundle.main.kobisKey)&movieCd=\(movieCode)"

    url += query

    performMovieInfoRequest(urlString: url, index: index)
  }

  func fetchPosterInfo(movieName: String, year: String) {
    var url = urlOmdb
    let query = "?t=\(movieName.replacingOccurrences(of: " ", with: "+"))&y=\(year)&apikey=\(Bundle.main.omdbKey)"

    url += query

    performPosterRequest(urlString: url)
  }

// MARK: - Perform Request

  func performBoxOfficeRequest(urlString: String) {
    if let url = URL(string: urlString) {
      let session = URLSession(configuration: .default)

      let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
          fatalError("boxOffice session task error")
        }

        if let safeData = data {
          if let boxOfficeResult = self.parseDaliyBoxOfficeJSON(safeData) {
            self.delegate?.didUpdateBoxOfficeList(boxOfficeResult)
          }
        }
      }

      task.resume()
    }
  }

  func performMovieInfoRequest(urlString: String, index: Int) {
    if let url = URL(string: urlString) {
      let session = URLSession(configuration: .default)

      let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
          fatalError("movieInfo session task error")
        }

        if let safeData = data {
          if let movieInfo = self.parseMovieInfoJSON(safeData) {
            self.delegate?.didUpdateMovieInfo(movieInfo, index)
          }
        }
      }

      task.resume()
    }

  }

  func performPosterRequest(urlString: String) {

  }

  // MARK: - Parse JSON

  func parseDaliyBoxOfficeJSON(_ resultData: Data) -> [DailyListObject]? {
    do {
      let decodedData = try decoder.decode(DailyBoxOfficeResult.self, from: resultData)

      return decodedData.boxOfficeResult.dailyBoxOfficeList
    } catch {
      print("parse boxOffice JSON error")
      return nil
    }
  }

//  func parseWeeklyBoxOfficeJSON(_ resultData: Data) -> ? {
//
//  }

  func parseMovieInfoJSON(_ resultData: Data) -> MovieInfo? {
    do {
      let decodedData = try decoder.decode(MovieDetailResult.self, from: resultData)

      return decodedData.movieInfoResult.movieInfo
    } catch {
      print("parse movieInfo JSON error")
      return nil
    }
  }

//  func parsePosterJSON(_ resultData: Data) -> DailyBoxOfficeResult? {
//
//  }
}
