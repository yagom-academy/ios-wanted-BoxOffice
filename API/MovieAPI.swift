//
//  MovieAPI.swift
//  BoxOffice
//
//  Created by 박호현 on 2022/10/18.
//

import Foundation

class MovieAPI{
 class func callAPI(targetDay: String, completion: @escaping (BoxOffice) -> Void) {
     
     let newDate = Date()
     let data = DateFormatter()
     data.locale = Locale(identifier: "ko_kr")
     data.dateFormat = "yyyy-MM-dd"
     let data_string = data.string(from: newDate)
     let removeString = data_string.components(separatedBy: ["-"]).joined()
     let change = String((Int(removeString) ?? 0) - 1)
     // 당일에 대한 영화목록이 나오지 않음. 따라서 당일의 전날에 대한 값을 넣음
     
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let urlString = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=f5eef3421c602c6cb7ea224104795888&targetDt=\(change)&wideAreaCd=0105001"
        
        let url: URL! = URL(string: urlString)
        let dataTask = session.dataTask(with: url) { data, response, error in
            let successRange = 200..<300
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else { return }
            
            guard let result = data else { return }
            let data = try! JSONDecoder().decode(BoxOffice.self, from: result)
            
            DispatchQueue.main.async {
                completion(data)
            }
        }
        dataTask.resume()
    }
}
