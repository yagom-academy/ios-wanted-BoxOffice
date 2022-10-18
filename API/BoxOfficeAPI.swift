//
//  BoxOfficeAPI.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/17.
//

import Foundation




class OfficeApi {
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
