//
//  MovieInfomationApi.swift
//  BoxOffice
//
//  Created by so on 2022/10/18.
//

import Foundation

class movieInfomationApi {
    class func getData(myApiKey:String, todays: String,itemPerPage:String, movieCd:String, completion: @escaping (InfomationCodable) -> Void) {
    let defaultSession = URLSession(configuration: .default)
    guard let url = URL(string: "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(myApiKey)&movieCd=\(movieCd)") else {
        print("URL is nil")
        return
    }
    let request = URLRequest(url: url)
    let dataTask = defaultSession.dataTask(with: request) { (data: Data?, response: URLResponse?, error: Error?) in
        guard error == nil else {
            print("Error occur: \(String(describing: error))")
            return
        }
        guard let data = data, let response = response as? HTTPURLResponse, response.statusCode == 200 else {
            return
        }
        let decoder = JSONDecoder()
        do {
            let result = try decoder.decode(InfomationCodable.self, from: data)
            DispatchQueue.main.async {
                completion(result)
              
            }
        } catch {
            print(error)
        }
    }
    
    dataTask.resume()
}
}



