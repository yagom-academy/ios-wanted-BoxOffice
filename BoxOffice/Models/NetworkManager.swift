//
//  NetworkManager.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/19.
//

import Foundation

protocol NetworkDelegate {
  func didUpdateBoxOfficeList(_ _result: [RankListObject], _ type: BoxOfficeType)
  func didUpdateMovieInfo(_ _movieInfo: MovieInfo, _ index: Int, _ type: BoxOfficeType)
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

  // Fetch Daily or Weekly Box Office
  func fetchMovie(targetDate: String, type: BoxOfficeType) {
    var url = urlKobis
    let query = "?targetDt=\(targetDate)&wideAreaCd=0105001&key=\(Bundle.main.kobisKey)"

    switch type {
    case .daily:
      url += type.rawValue + query
      self.performRequest(urlString: url, type: .daily)
    case .weekly:
      url += type.rawValue + query + "&weekGb=0"
      self.performRequest(urlString: url, type: .weekly)
    }
  }

  // Fetch Movie Detail Info
  func fetchMovie(movieCode: String, index: Int, type: BoxOfficeType) {
    var url = urlKobis + "movie/searchMovieInfo.json"
    let query = "?key=\(Bundle.main.kobisKey)&movieCd=\(movieCode)"

    url += query

    performRequest(urlString: url, index: index, type: type)
  }

  // Fetch Movie Poster Info
  func fetchMovie(movieName: String, year: String, movieCode: String, index: Int) {
    var url = urlOmdb
    let query = "?t=\(movieName.replacingOccurrences(of: " ", with: "+"))&y=\(year)&apikey=\(Bundle.main.omdbKey)"

    url += query

    performRequest(urlString: url, movieCode: movieCode, index: index)
  }

// MARK: - Perform Request

  // Perform Box Office Request
  func performRequest(urlString: String, type: BoxOfficeType) {
    if let url = URL(string: urlString) {
      let session = URLSession(configuration: .default)

      let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
          fatalError("boxOffice session task error")
        }

        if let safeData = data {
          if let boxOfficeResult = self.parseBoxOfficeJSON(safeData, type) {
            self.delegate?.didUpdateBoxOfficeList(boxOfficeResult, type)
          }
        }
      }

      task.resume()
    }
  }

  // Perform Movie Detail Info Request
  func performRequest(urlString: String, index: Int, type: BoxOfficeType) {
    if let url = URL(string: urlString) {
      let session = URLSession(configuration: .default)

      let task = session.dataTask(with: url) { data, response, error in
        if error != nil {
          fatalError("movieInfo session task error")
        }

        if let safeData = data {
          if let movieInfo = self.parseMovieInfoJSON(safeData) {
            self.delegate?.didUpdateMovieInfo(movieInfo, index, type)
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
  func parseBoxOfficeJSON(_ resultData: Data, _ type: BoxOfficeType) -> [RankListObject]? {
    do {

      switch type {
      case .daily:
        let decodedData = try decoder.decode(DailyBoxOfficeResult.self, from: resultData)
        return decodedData.boxOfficeResult.dailyBoxOfficeList
      case .weekly:
        let decodedData = try decoder.decode(WeeklyBoxOfficeResult.self, from: resultData)
        return decodedData.boxOfficeResult.weeklyBoxOfficeList
      }

    } catch {
      print("parse boxOffice JSON error")
      return nil
    }
  }

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
