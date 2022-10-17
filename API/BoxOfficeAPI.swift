//
//  BoxOfficeAPI.swift
//  BoxOffice
//
//  Created by 1 on 2022/10/17.
//

import Foundation




class OfficeApi {
    let key = "9a03d4e2eafea3c2e79c80e98ac2919c"
    let targetData = "20120101"
//    var dataStructure: BoxOffice?

    
    func callAPI(movieName: String, completion: @escaping (MainBoxOfficeList) -> Void ) {
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        let urlString =
        "http://kobis.or.kr/kobisopenapi/webservice/rest/boxoffice/searchDailyBoxOfficeList.json?key=\(key)&targetDt=\(targetData)"
        
        guard let url = URL(string: urlString) else { return }
        
        let dataTask = session.dataTask(with: url) { data, response, error in
            let successRange = 200..<300
            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else { return }
            // 파싱하는 부분
            guard let resultData = data else { return }
            let decoder = JSONDecoder()
            let decodedData = try! decoder.decode(MainBoxOfficeList.self, from: resultData)
            print("나타나라 제발\(decodedData)")
            DispatchQueue.main.async {
                completion(decodedData)
            }
        }
        dataTask.resume()
    }
}

//            do {
//                self.dataStructure = try? JSONDecoder().decode(BoxOffice.self, from: resultData)
//                DispatchQueue.main.async(execute: {
//                    if let list = self.dataStructure?.boxOfficeResult.boxOfficeList {
//                        for movie in list {
//                            print("\(movie.rank), \(String(describing: movie.movieNm)) : \(movie.audiAcc), 누적: \(movie.audiAcc)")
//                        }
//                    }
//                })
//            } catch {
//                print("Data Error")
//            }



//        let dataTask = session.dataTask(with: url) { data, response, error in
//            let successRange = 200..<300
//            guard error == nil, let statusCode = (response as? HTTPURLResponse)?.statusCode, successRange.contains(statusCode) else {
//                return
//            }

//            let decoder = JSONDecoder()
//            let decodedData = try! decoder.decode(MainBoxOfficeList.self, from: resultData)
//            DispatchQueue.main.async {
//                completion(decodedData)
//            }
