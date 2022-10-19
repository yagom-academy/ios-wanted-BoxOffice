//
//  MovieAPI.swift
//  BoxOffice
//
//  Created by 박호현 on 2022/10/18.
//

import Foundation

class MovieAPI{
 class func callAPI(targetDay: String, completion: @escaping (BoxOffice) -> Void) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let urlString = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=20120101&wideAreaCd=0105001"
        
        let url: URL! = URL(string: urlString)
        let dataTask = session.dataTask(with: url) { data, response, error in
            let successRange = 200..<300
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else { return }
            
            guard let result = data else { return }
            let data = try! JSONDecoder().decode(BoxOffice.self, from: result)
            print(data)
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
        dataTask.resume()
    }
}
