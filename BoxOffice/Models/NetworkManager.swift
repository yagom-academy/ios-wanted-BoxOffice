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
  func didUpdatePosterInfo(_ _imagePath: String, _ index: Int)
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

  // Fetch Daily Box Office
  func fetchMovie(targetDate: String, type: BoxOfficeType) {
    var url = urlKobis
    let query = "?targetDt=\(targetDate)&wideAreaCd=0105001&key=\(Bundle.main.kobisKey)"

    switch type {
    case .daily:
      url += type.rawValue + query
    case .weekly:
      url += type.rawValue + query
    }

    self.performRequest(urlString: url)
  }

  // Fetch Movie Detail Info
  func fetchMovie(movieCode: String, index: Int) {
    var url = urlKobis + "movie/searchMovieInfo.json"
    let query = "?key=\(Bundle.main.kobisKey)&movieCd=\(movieCode)"

    url += query

    performRequest(urlString: url, index: index)
  }

  // Fetch Movie Poster Info
  func fetchMovie(movieName: String, year: String, movieCode: String, index: Int) {
    var url = urlOmdb
    let query = "?t=\(movieName.replacingOccurrences(of: " ", with: "+"))&y=\(year)&apikey=\(Bundle.main.omdbKey)"

    url += query

    performRequest(urlString: url, movieCode: movieCode, index: index)
  }

// MARK: - Perform Request

  // Perform Daily Box Office Request
  func performRequest(urlString: String) {
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

  // Perform Movie Detail Info Request
  func performRequest(urlString: String, index: Int) {
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

  // Perform Movie Poster Request
  func performRequest(urlString: String, movieCode: String, index: Int) {
    if let url = URL(string: urlString) {
      let session = URLSession(configuration: .default)

      let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
          fatalError("poster session task error")
        }

        if let safeData = data {
          if let posterInfo = self.parsePosterJSON(safeData) {

            if posterInfo.Poster.contains("http") {
              PosterCache.savePoster(URL(string: posterInfo.Poster)!, movieCode)
            }

            self.delegate?.didUpdatePosterInfo(posterInfo.Poster, index)
          }
        }
      }

      task.resume()
    }
  }

  // MARK: - Parse JSON

  // TODO: - 파싱결과 enum 만들어서 함수 하나로 줄이기
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

  func parsePosterJSON(_ resultData: Data) -> OMDbResult? {
    do {
      let decodedData = try decoder.decode(OMDbResult.self, from: resultData)

      return decodedData
    } catch {
      print("parse posterInfo JSON error")
      return nil
    }
  }
}
