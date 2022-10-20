//
//  WeekAPI.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/20.
//

import Foundation

class WeekApi {
    class func weekApi(targetDay: String, completion: @escaping (Week) -> Void ) {
        let key = "9a03d4e2eafea3c2e79c80e98ac2919c"
        let targetDay = "20190201" 
        let seoul = "0105001"
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let urlString = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchWeeklyBoxOfficeList.json?key=\(key)&targetDt=\(targetDay)&weekGb=0&wideAreaCd=\(seoul)"
        
        guard let url = URL(string: urlString) else { return }
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            let successRange = 200..<300
            
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else { return }
            
            guard let resultData = data else { return }
            let decoder = JSONDecoder()
            let decodedData = try! decoder.decode(Week.self, from: resultData)
            DispatchQueue.main.async {
                completion(decodedData)
            }
        }
        dataTask.resume()
    }
}
