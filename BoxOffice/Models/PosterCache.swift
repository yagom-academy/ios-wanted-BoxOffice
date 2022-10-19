//
//  PosterCache.swift
//  BoxOffice
//
//  Created by Subin Kim on 2022/10/19.
//

import UIKit

class PosterCache {
  static let shared = NSCache<NSString, UIImage>()

  static func savePoster(_ url: URL, _ movieCode: String) {
    if shared.object(forKey: movieCode as NSString) == nil {
      var request = URLRequest(url: url)
      request.httpMethod = "GET"

      URLSession.shared.dataTask(with: request) { data, response, error in
        guard let _response = response as? HTTPURLResponse, _response.statusCode == 200,
              let _data = data, error == nil,
              let poster = UIImage(data: _data)
        else {
          print("Download Poster Fail", url)
          return
        }

        shared.setObject(poster, forKey: movieCode as NSString)

      }.resume()
    }
  }

  static func loadPoster(_ movieCode: String) -> UIImage {
    return shared.object(forKey: movieCode as NSString) ?? UIImage(named: "noPoster")!
  }
}
