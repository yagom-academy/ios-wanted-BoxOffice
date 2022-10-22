//
//  DetailAPI.swift
//  BoxOffice
//
//  Created by 박호현 on 2022/10/22.
//

import Foundation

class DetailAPI{
 class func detailAPI(tagetdata: String, completion: @escaping (Welcome) -> Void) {
     
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let urlString = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=f5eef3421c602c6cb7ea224104795888&movieCd=20124079"
        
        let url: URL! = URL(string: urlString)
        let dataTask = session.dataTask(with: url) { data, response, error in
            let successRange = 200..<300
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else { return }
            
            guard let result = data else { return }
            print(result)
            let data = try! JSONDecoder().decode(Welcome.self, from: result)
            print(data)
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
        dataTask.resume()
    }
}
