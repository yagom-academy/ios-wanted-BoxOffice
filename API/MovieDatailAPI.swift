//
//  MovieDatailAPI.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/18.
//

import Foundation


class MovieApi {
    class func callApiDetail(targetData: String, completion: @escaping (Empty) -> Void ) {
        let key = "9a03d4e2eafea3c2e79c80e98ac2919c"
        let targetData = "20124079"
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let urlString = "http://www.kobis.or.kr/kobisopenapi/webservice/rest/movie/searchMovieInfo.json?key=\(key)&movieCd=\(targetData)"
        
        guard let url = URL(string: urlString) else { return }
        let dataTask = session.dataTask(with: url) { data, response, error in
            let successRange = 200..<300
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else { return }
            
            guard let resultData = data else { return }
            let decoder = JSONDecoder()
            guard let decodedData = try? decoder.decode(Empty.self, from: resultData) else { return }
            DispatchQueue.main.async {
                completion(decodedData)
            }
        }
        dataTask.resume()
    }
}

class OfficeApiSecond {
    class func callAPI(targetDay: String, completion: @escaping (BoxOffice) -> Void ) {
        let key = "9a03d4e2eafea3c2e79c80e98ac2919c"
        let targetDay = "20190201" //치킨시즌
        let seoul = "0105001"
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let urlString = "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?targetDt=\(targetDay)&key=\(key)&wideAreaCd=\(seoul)"
        
        guard let url = URL(string: urlString) else { return }
        let dataTask = session.dataTask(with: url) { data, response, error in
            let successRange = 200..<300
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else { return }
            // 파싱하는 부분
            guard let resultData = data else { return }
            //            print("나타나\(resultData)")
            let decoder = JSONDecoder()
            let decodedData = try! decoder.decode(BoxOffice.self, from: resultData)
            //            print("나타나라\(decodedData)")
            DispatchQueue.main.async {
                completion(decodedData)
            }
            //            print("나타나라제발\(decodedData)")
        }
        dataTask.resume()
    }
}
