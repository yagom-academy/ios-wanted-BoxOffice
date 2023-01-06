//
//  MoviePosterAPI.swift
//  BoxOffice
//
//  Created by Baek on 2023/01/04.
//

import Foundation

class MoviePosterAPI {
    let session: URLSessionProtocol
    
    init(session: URLSessionProtocol = URLSession.shared){
        self.session = session
    }
    
    func dataTask(by movieName: String, completion: @escaping (Result<MoviePosterInfo, Error>) -> ()) {
        let posterURL = "http://www.omdbapi.com/?apikey=e989f669&s=\(movieName)"
        guard let encodedPosterURL = posterURL.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: encodedPosterURL) else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let task = session.dataTask(with: request) { (data, response, error) in
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                return completion(.failure(CustomError.statusCodeError))
            }
            
            if let data = data {
                do {
                    let decodeData = try JSONDecoder().decode(MoviePosterInfo.self, from: data)
                    completion(.success(decodeData))
                }
                catch {
                    print(error.localizedDescription)
                }
            }
        }
        task.resume()
    }
}
